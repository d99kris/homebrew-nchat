class Nchat < Formula
  desc "Terminal-based Telegram / WhatsApp client"
  homepage "https://github.com/d99kris/nchat"
  url "https://github.com/d99kris/nchat/archive/refs/tags/v5.4.2.tar.gz"
  sha256 "1957c7817c45f44ab6bb6e425b074b2484f74cf90b32835f1cb2e6b2b008f370"
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
