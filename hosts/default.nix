{hostname, ...}: {
  imports = [
    ./${hostname} # based on a nixoConfiguration's specialArgs.hostname, picks the correct host folder
  ];
}
