{pkg, ...}:
{
  users.users.esauder = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ];
  };
}
