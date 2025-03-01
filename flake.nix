{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      # Import local override if it exists
      imports = [
        (
          if builtins.pathExists ./local.nix
          then ./local.nix
          else {}
        )
      ];

      # Sensible defaults
      systems = [
        "x86_64-linux"
        "i686-linux"
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
        node = pkgs.nodejs;
        nil = pkgs.nil;
        task = pkgs.go-task;
        coreutils = pkgs.coreutils;
        trunk = pkgs.trunk-io;
        copier = pkgs.copier;
        liquidsoap = pkgs.liquidsoap;
        redocly = pkgs.redocly;
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
            # Allow packages with broken dependencies
            allowBroken = true;
            # Allow packages with unsupported system
            allowUnsupportedSystem = true;
          };
        };

        # Set which formatter should be used
        formatter = pkgs.alejandra;

        # Define multiple development shells for different purposes
        devShells = {
          default = pkgs.mkShell {
            name = "dev";

            packages = [
              node
              nil
              task
              coreutils
              trunk
              copier
              liquidsoap
              redocly
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
              redocly
              tini
              su-exec
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          template = pkgs.mkShell {
            name = "template";

            packages = [
              task
              coreutils
              copier
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          lint = pkgs.mkShell {
            name = "lint";

            packages = [
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
