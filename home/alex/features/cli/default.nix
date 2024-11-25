{pkgs, ...}: {
  imports = [
    ./fish
    ./nvim

    ./bash.nix
  ];
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    nixfmt-rfc-style # Official Nix formatter to ensure uniform style

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # editors
    vim

    # misc
    file
    which
    tree
    gnumake
    gnused
    gnutar
    gawk
    zstd
    gnupg
    xclip
    wget
    curl
    neofetch
    nnn # terminal file manager

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iftop # network monitoring
    lsof # list open files
    pciutils # lspci
  ] ++ (pkgs.lib.optionals pkgs.stdenv.isLinux [
    libgcc
    iotop # io monitoring
    strace # system call monitoring
    ltrace # library call monitoring

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    usbutils # lsusb
  ]);
}