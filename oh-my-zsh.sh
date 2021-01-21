#!/usr/bin/env bash
THEME=powerlevel10k/powerlevel10k
PLUGINS=""
ZSHRC_APPEND=""

plugins_count=0;
while getopts ":t:p:a:" opt; do
    case ${opt} in
        t)  THEME=$OPTARG
            ;;
        p)  PLUGINS="${PLUGINS}$OPTARG "
            plugins_count=$((plugins_count + 1))
            ;;
        a)  ZSHRC_APPEND="$ZSHRC_APPEND\n$OPTARG"
            ;;
        \?)
            echo "Invalid option: $OPTARG" 1>&2
            ;;
        :)
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            ;;
    esac
done
shift $((OPTIND -1))

echo
echo "Installing Oh-My-Zsh with:"
echo "  THEME   = $THEME"
echo "  PLUGINS = $PLUGINS"
echo
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"



# Generate plugin list
plugin_list=""
plugins_processed=0
for plugin in $PLUGINS; do
    if [ "`echo $plugin | grep -E '^http.*'`" != "" ]; then
        plugin_name=`basename $plugin`
        git clone $plugin $HOME/.oh-my-zsh/custom/plugins/$plugin_name
    else
        plugin_name=$plugin
    fi

    plugins_processed=$((plugins_processed + 1))
    if [[ $plugins_processed == $plugins_count ]]; then
        plugin_list="${plugin_list}$plugin_name"
    else
        plugin_list="${plugin_list}$plugin_name "
    fi
done

# Handle themes
if [ "`echo $THEME | grep -E '^http.*'`" != "" ]; then
    theme_repo=`basename $THEME`
    THEME_DIR="$HOME/.oh-my-zsh/custom/themes/$theme_repo"
    git clone $THEME $THEME_DIR
    theme_name=`cd $THEME_DIR; ls *.zsh-theme | head -1`
    theme_name="${theme_name%.zsh-theme}"
    THEME="$theme_repo/$theme_name"
fi


zshrc_template() {
    _HOME=$1;
    _THEME=$2; shift; shift
    _PLUGINS=$*;

    cat <<EOM
export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'
export TERM=xterm
##### Zsh/Oh-my-Zsh Configuration
export ZSH="$_HOME/.oh-my-zsh"
ZSH_THEME="${_THEME}"
plugins=($_PLUGINS)
EOM
    printf "$ZSHRC_APPEND"
    printf "\nsource \$ZSH/oh-my-zsh.sh\n"
}

# generate the template
zshrc_template "$HOME" "$THEME" "$plugin_list" > $HOME/.zshrc

# Install powerlevel10k if no other theme was specified
if [ "$THEME" = "powerlevel10k/powerlevel10k" ]; then
    git clone https://github.com/romkatv/powerlevel10k $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    powerline10k_config >> $HOME/.zshrc
fi
