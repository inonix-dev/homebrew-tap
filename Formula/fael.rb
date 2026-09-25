class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/inonix-dev/fael"
  version "0.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.3/fael-aarch64-apple-darwin.tar.xz"
      sha256 "082cc1b8800a3471e382c046f9035d08de13385fb8ec53ac507cacc4f74ca323"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.3/fael-x86_64-apple-darwin.tar.xz"
      sha256 "68be36a477c983abb360c3c90cd4b2b2ca12e9f53c9ce42ae96ecfb901128e36"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.3/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d7c91eca573fbc74c53ed18a7157ed5a6bda849a9ee150ed7ba4361a7f4933b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/inonix-dev/fael/releases/download/v0.0.3/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b3a3c1e62e9c60ca67ccb802b4f0bbc2539a71d45625d93ce6dc88ba1c79ee5c"
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
