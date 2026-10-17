{
  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    multiverse = {
      url = "github:fzakaria/nixpkgs-multiverse";
    };

    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-26.05";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        overlays = {
          default = final: prev: {
            # Add multiverse as an attribute
            multiverse = inputs.multiverse.lib.mkMultiverse {
              config = {
                # Allow packages with non-free licenses
                allowUnfree = true;
              };

              system = final.stdenv.hostPlatform.system;
            };
          };
        };
      };

      # Sensible defaults
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: let
        nix = pkgs.nix;
        node = pkgs.nodejs_26;
        nh = pkgs.nh;
        nil = pkgs.nil;
        task = pkgs.go-task;
        coreutils = pkgs.coreutils;
        trunk = pkgs.trunk-io;
        copier = pkgs.python314.withPackages (ps: [ps.copier]);
        liquidsoap = pkgs.liquidsoap;
        ffmpeg = pkgs.ffmpeg;
        tini = pkgs.tini;
        su-exec = pkgs.su-exec;
      in {
        # Override pkgs argument
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;

          config = {
            # Allow packages with non-free licenses
            allowUnfree = true;
          };

          overlays = [
            # Use default overlay
            inputs.self.overlays.default
          ];
        };

        # Set which formatter should be used
        formatter = pkgs.alejandra;

        # Define multiple development shells for different purposes
        devShells = {
          default = pkgs.mkShell {
            name = "dev";

            packages = [
              nix
              node
              nh
              nil
              task
              coreutils
              trunk
              copier
              liquidsoap
              ffmpeg
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          runtime = pkgs.mkShell {
            name = "runtime";

            packages = [
              liquidsoap
              tini
              su-exec
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          lint = pkgs.mkShell {
            name = "lint";

            packages = [
              nix
              node
              task
              coreutils
              trunk
              liquidsoap
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          docs = pkgs.mkShell {
            name = "docs";

            packages = [
              node
              task
              coreutils
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };
        };
      };
    };
}
