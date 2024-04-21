{ userSettings, authorizedKeys ? [], ... }:

{
  # Enable incoming ssh
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${userSettings.username}.openssh.authorizedKeys.keys = [
    # dan-wks-3080 windows key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIdjUmRaJCKDBRZHI6VyKKOOdWD08Ezg5Aqa+u3cL8ZNdAzPudikv5x6RPemcjWg4Pj0s8nXsFl9UYJmDW7tgCdaf6m20aWu/0R3tGjOc+O+MfGnGkbdvH0gl9gm7OtGeywn1BO777SlmXnu788+69DLcXftjgf4za/AW3mP/LnPPp2TKgONi/+4nKQSC/20H0yAZib7u4cav4QBHTy2u7UvmDLHKPGfP4OwINVVub2LI+bzMrbTqs2LrZzG9JyfdNTojZh6lszubkVQ9cNojsWcmovn2iswruTgtjvzxeENEWHk6VdJUKr1bSDusIQ0ucDTuqbJqA80bP9l4m+GqSZfTMjNC+m/gljSW33oDmkiXgW5VZb6RZV3gktqngDT8ghfkFkHi3JfRtGy1THWEOskGz+fGQ5w9j9Q9tB9WBGqfMxE0u6P/65a+bnmypntGv649RpxD3nJ7e7FwPzy9Ekcoy7IZffDuoTvqbqjIcAfyHOT9iLFPg233KuYMxGi0= dgonz@dan-wks-3080"
    # note: ssh-copy-id will add user@your-machine after the public key
    # but we can remove the "@your-machine" part
  ];
  # TODO: refactor to pass in authorizedKeys
  #users.users.${userSettings.username}.openssh.authorizedKeys.keys = authorizedKeys;
}
