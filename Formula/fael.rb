class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/inonix-dev/fael"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.4/fael-aarch64-apple-darwin.tar.xz"
      sha256 "0d378718c951156976d7d801f53e89bfe008793c5cf7d3f9a662894f32cb1724"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.4/fael-x86_64-apple-darwin.tar.xz"
      sha256 "63a9f9e42d2d206b5199dd78566b44aaea773cbf1afa6bc2b25a1b909a4d9b59"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.4/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3464b1770b2e470fa0d5fe01b12a725d9341aafc7a6880be3e4ca20c9a96c317"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.4/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8950bcbdcaa285f3cf9d67a35351b2cbe35c68d8d99e0ac842cab3e4743f83fe"
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
