# ansible-recap

Little bash script to fetch final stats from an `ansible check`
result exported as `JSON`.  
It is intended to summarize changes/failures/unreachable errors
in batches and only notifies when one of thoses states are found.

Example output:
```
     Status    │ Host               │    Changes │   Failures │ Unreachable
  ─────────────┼────────────────────┼────────────┼────────────┼─────────────
       🟨      │ dev.app.client     │          6 │          0 │           0
       🟨      │ prod.app.client    │          5 │          0 │           0
       🟨      │ state.app.client   │          5 │          0 │           0
```

## Installation

### Nix

Add this repo as inputs:
```nix
ansible-recap = {
  url = "github:gfriloux/ansible-recap";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Merge overlay into pkgs:
```
pkgs = import nixpkgs {
  inherit system;
  overlays = [ ansible-recap.overlays.default ];
};
```

You can now install using `pkgs.ansible-recap`.

## Usage

Set this into `ansible.cfg`:
```ini
[defaults]
callback_result_format = json
stdout_callback = ansible.posix.json
```

You can now execute your `playbook`:
```
ansible-playbook --check -i hosts playbook.yml >result.json
```

And parse `result.json`:
```
ansible-recap result.json
```

