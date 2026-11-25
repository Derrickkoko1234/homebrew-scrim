class ScrimCli < Formula
  desc "Command-line client for Scrim for Git"
  homepage "https://github.com/Derrickkoko1234/scrim#readme"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Derrickkoko1234/scrim/releases/download/v0.1.0/scrim-cli-aarch64-apple-darwin.tar.xz"
      sha256 "abe62516f89d4a5c3093ed0e51dc5153551e8555e8f167fb85e6a88864685e55"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Derrickkoko1234/scrim/releases/download/v0.1.0/scrim-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e433257e26f517cacf6b37bbff03f1d2e9e19d8c77ab3bbf715336c2f4f45bf0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Derrickkoko1234/scrim/releases/download/v0.1.0/scrim-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7897a7175744bd01d9d4840d1f34d8e8bf1807ebaa48a2bd24eeb12b2c207ba5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Derrickkoko1234/scrim/releases/download/v0.1.0/scrim-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fd3dd4283afb69a3f42c592d138c644b385d8c3deb7ebae72f166dea1b457197"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
      bin.install "git-scrim", "scrim"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "git-scrim", "scrim"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "git-scrim", "scrim"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "git-scrim", "scrim"
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
