# Pop!_OS (COSMIC) - home-manager standalone
{
  imports = [
    ./global
    ./features/dev
  ];

  targets.genericLinux.enable = true;
}
