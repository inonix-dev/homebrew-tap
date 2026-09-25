class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/inonix-dev/fael"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.1/fael-aarch64-apple-darwin.tar.xz"
      sha256 "334e7c7720b8196521701c30885e717828cb4d46712a1f52d7a06f9aca3dae8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.1/fael-x86_64-apple-darwin.tar.xz"
      sha256 "a0389017095f5135bac50942e88aab6a2bc2e9b2e93aaca2992755cd6f6bad75"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.1/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1fd6beeee51aeec2e99097895e9763ebd05cbc223911080227689f6d6e0fe5f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.1/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aaf94ae4663cf93f5a55443973796ccd61982b3e6ce28f850b1f4564d3bfba57"
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
