module.exports = {
  brew: [
    "ack",
    "adns",
    "ag",
    "aom",
    "apr",
    "apr-util",
    "autojump", //github.com/wting/autojump // https
    "bash",
    "bat", //github.com/sharkdp/bat, alternative to `cat`: https
    "bdw-gc",
    "berkeley-db",
    "boost",
    "brew-cask-completion",
    "brotli",
    "c-ares",
    "ca-certificates",
    "cairo",
    "coreutils", // Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`. Install GNU core utilities (those that come with macOS are outdated)
    "cowsay",
    "cscope",
    "dive",
    "docbook",
    "docbook-xsl",
    "docker-completion",
    "docker-slim",
    "dos2unix",
    "double-conversion",
    "findutils", // Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
    "fmt",
    "folly",
    "fontconfig",
    "fortune",
    "freetype",
    "fribidi",
    "fzf",
    "gawk", // ensure gawk gets good readline
    "gd",
    "gdbm",
    "gdk-pixbuf",
    "gettext",
    "gflags",
    "ghostscript",
    "giflib",
    "gifsicle",
    "git",
    "git-credential-manager",
    "git-open",
    "glib",
    "glog",
    "gmp",
    "gnu-getopt",
    "gnu-sed --with-default-names",
    "gnupg",
    "gnutls",
    "gobject-introspection",
    "graphite2",
    "graphviz",
    "grep --with-default-names", // upgrade grep so we can get things like inverted match (-v)
    "gts",
    "guile",
    "harfbuzz",
    "htop",
    "httpie",
    "icu4c",
    "imagemagick",
    "imagesnap",
    "imath",
    "jasper",
    "jbig2dec",
    "jemalloc",
    "jpeg",
    "jpeg-xl",
    "jq", // jq is a sort of JSON grep
    "lazygit",
    "libassuan",
    "libde265",
    "libev",
    "libevent",
    "libffi",
    "libgcrypt",
    "libgpg-error",
    "libheif",
    "libidn",
    "libidn2",
    "libksba",
    "liblqr",
    "libnghttp2",
    "libomp",
    "libpng",
    "libpthread-stubs",
    "librsvg",
    "libtasn1",
    "libtiff",
    "libtool",
    "libunistring",
    "libusb",
    "libuv",
    "libvmaf",
    "libx11",
    "libxau",
    "libxcb",
    "libxdmcp",
    "libxext",
    "libxrender",
    "libyaml",
    "little-cms2",
    "lua",
    "lz4",
    "lzo",
    "m4",
    "mas",
    "maven",
    "maven-completion",
    "moreutils", // Install some other useful utilities like `sponge`
    "mpdecimal",
    "mpfr",
    "ncurses",
    "netpbm",
    "nettle",
    "nghttp2",
    "nmap",
    "node",
    "npth",
    "nvm",
    "oniguruma",
    "openconnect",
    "openexr",
    "openjdk",
    "openjpeg",
    "p11-kit",
    "pango",
    "pcre",
    "pcre2",
    "perl",
    "pinentry",
    "pixman",
    "pkg-config",
    "python",
    "readline",
    "reattach-to-user-namespace",
    "ruby", // better/more recent version of screen
    "shared-mime-info",
    "snappy",
    "sqlite",
    "stoken",
    "subversion",
    "tcl-tk",
    "telnet",
    "the_silver_searcher",
    "tmux",
    "todo-txt",
    "tree",
    "ttyrec",
    "unbound",
    "utf8proc",
    "vim --with-client-server --with-override-system-vi", // better, more recent vim
    "watch",
    "watchman",
    "webp",
    "wget --enable-iri", // Install wget with IRI support
    "x265",
    "xmlto",
    "xorgproto",
    "xz",
    "yarn",
    "yarn-completion",
    "z",
    "zsh",
    "zsh-autosuggestions",
    "zsh-completions",
    "zsh-git-prompt",
    "zsh-history-substring-search",
    "zsh-lovers",
    "zsh-navigation-tools",
    "zsh-syntax-highlighting",
    "zstd",
    // so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file" // Install GNU `sed`, overwriting the built-in `sed`
    //github.com/jkbrzt/httpie // https
    //github.com/mas-cli/mas // Mac App Store CLI: https
    //www.lcdf.org/gifsicle/ (because I'm a gif junky) // http
  ],
  cask: [
    "1password@7",
    "a-better-finder-rename",
    "acorn",
    "aerial",
    "alfred@4",
    "arc",
    "bitwarden",
    "caffeine",
    "citrix-workspace",
    "claude",
    "contexts",
    "cursor",
    "cyberduck",
    "diffmerge",
    "disk-inventory-x",
    "docker",
    "duckduckgo",
    "element",
    "figma",
    "firefox",
    "font-awesome-terminal-fonts",
    "font-fira-code",
    "font-fontawesome",
    "font-hack",
    "font-hack-nerd-font",
    "font-ia-writer-duo",
    "font-ia-writer-duospace",
    "font-ia-writer-mono",
    "font-ia-writer-quattro",
    "font-inconsolata-dz-for-powerline",
    "font-inconsolata-for-powerline",
    "font-inconsolata-g-for-powerline",
    "font-meslo-for-powerline",
    "font-meslo-lg",
    "font-powerline-symbols",
    "font-roboto-mono",
    "font-roboto-mono-for-powerline",
    "font-source-code-pro",
    "font-source-code-pro-for-powerline",
    "free-ruler",
    "fujitsu-scansnap-home",
    "garmin-express",
    "git-credential-manager",
    "github",
    "google-chrome",
    "google-drive",
    "handbrake-app",
    "intellij-idea",
    "iterm2",
    "kap",
    "little-snitch",
    "lm-studio",
    "macpass",
    "media-converter",
    "meta",
    "micro-snitch",
    "microsoft-auto-update",
    "microsoft-edge",
    "microsoft-office",
    "microsoft-teams",
    "miro",
    "monodraw",
    "obsidian",
    "allamac",
    "omnifocus",
    "omnigraffle",
    "omnioutliner",
    "omniplan",
    "openvpn-connect",
    "plex",
    "plexamp",
    "postman",
    "rectangle",
    "send-to-kindle",
    "signal",
    "slack",
    "soapui",
    "sonos",
    "synergy",
    "synology-chat",
    "synology-drive",
    "telegram",
    "the-unarchiver",
    "tor-browser",
    "visual-studio-code",
    "vlc",
    "vyprvpn",
    "whatsapp",
    "zed",
    "zoom",
  ],
  gem: [],
  npm: [
    "antic",
    //'buzzphrase',
    "eslint",
    //'instant-markdown-d',
    // 'generator-dockerize',
    // 'gulp',
    "npm-check-updates",
    //'prettyjson',
    //'trash',
    //'vtop'
    // ,'yo'
  ],
};
