class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/inonix-dev/fael"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.5/fael-aarch64-apple-darwin.tar.xz"
      sha256 "7d1c7da2bd3cd5dc855ee98f96ef6773565a4fd1e68c97191bc246b0fe6e1a6f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.5/fael-x86_64-apple-darwin.tar.xz"
      sha256 "7d7e4f514caad6d9b3a68840eeed15d9153615ee7ae5272c8dfcf35b9ae34cf8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.5/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "afe595b18aebd46a41cd65b8b5b23eb7bbd49bf8c53cec7a42e3aa0a389ef9ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.5/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "edcd803813e905837d895202cba16d85215c793f2f25c5dca0ea0d34fa1b9ab8"
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
