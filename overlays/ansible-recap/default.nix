{ channels, inputs, ... }:

final: prev: {
  ansible-recap = inputs.self.packages.${final.system}.ansible-recap;
}
