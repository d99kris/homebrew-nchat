class Nchat < Formula
  desc "Terminal-based Telegram / WhatsApp client"
  homepage "https://github.com/d99kris/nchat"
  url "https://github.com/d99kris/nchat/archive/refs/tags/v5.9.15.tar.gz"
  sha256 "5e9b9017d7bad620b0d8e9731eb919eba542494d6e7cb7c66db7b4059e72ccab"
  license "MIT"

  option "without-whatsapp"
  option "without-telegram"

  depends_on "ccache"
  depends_on "cmake" => :build
  depends_on "go"
  depends_on "gperf"
  depends_on "help2man"
  depends_on "libmagic"
  depends_on "ncurses"
  depends_on "openssl"
  depends_on "readline"
  depends_on "sqlite"

  def install
    protocols = []
    if build.without? "telegram"
      protocols << "-DHAS_TELEGRAM=OFF"
    end
    if build.without? "whatsapp"
      protocols << "-DHAS_WHATSAPP=OFF"
    end
    mkdir "build" do
      system "cmake", "..", *protocols, *std_cmake_args
      system "make", "-s"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/nchat", "--version"
  end
end
