{
    boot.initrd.systemd.enable = true;
    boot.loader.systemd-boot.enable = true;
    # Limit number of config generations to keep to limit disk usage
    boot.loader.systemd-boot.configurationLimit = 10;
}