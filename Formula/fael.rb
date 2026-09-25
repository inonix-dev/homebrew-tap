class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/inonix-dev/fael"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.1.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "6109046c28d4697dae8bfa48f0a6ffb62dd9da800a9dbf5d4c4e5203623b13e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.1.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "86a52f413f0b5d60dd860fd0bd212c118913eafb68fc14d7de3bff1167cea5d3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.1.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3926aaa4392e96a603562c5154412a99b0a48414a18ae10b00bf779318cfc7df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.1.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9063d536fa4b6bee76634ed6c3da068ff881cd49a6a48c748f01e90e51a2b9b8"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "fael"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fael"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fael"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fael"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
