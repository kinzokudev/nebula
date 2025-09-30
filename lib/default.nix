{
  libPre,
  inputs,
  ...
}:
libPre.extend (
  self: _: {
    custom = import ./custom {
      inherit inputs;
      lib = self;
    };
  }
)
