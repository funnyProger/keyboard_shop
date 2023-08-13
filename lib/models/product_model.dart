class Product {
  String productImage = "n/d";
  String get image {return productImage;}
  void setImage(String value) => productImage = value;

  String productName = "n/d";
  String get name {return productName;}
  void setName(String value) => productName = value;

  String productPrice = "n/d";
  String get price {return productPrice;}
  void setPrice(String value) => productPrice = value;

  Product(this.productImage, this.productName, this.productPrice);



}

List<Product> getList() {
  List<Product> list = [];
  list.add(Product("https://static.insales-cdn.com/r/kWk6FOodnv0/rs:fit:1920:1920:1/plain/images/products/1/7819/736894603/1.jpg@webp", "Leopold FC650M Double Space BT Gray", "14 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/W2RJuOv3qpQ/rs:fit:1920:1920:1/plain/images/products/1/4067/592842723/Vortex_Tab_60.jpg@webp", "Vortex Tab 60", "13 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/YbxHax8eKXc/rs:fit:1920:1920:1/plain/images/products/1/7687/671874567/12.jpg@webp", "Varmilo Shurikey Saizo 001", "15 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/hhJqMIFyYQs/rs:fit:1920:1920:1/plain/images/products/1/6083/595982275/1_Varmilo_Moonlight_87_white.webp", "Varmilo Moonlight V2 87", "15 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/YR6trYOeK-A/rs:fit:1920:1920:1/plain/images/products/1/151/603021463/87.jpg@webp", "Varmilo Yakumo V2 87", "16 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/7-tZjMUuf_0/rs:fit:1920:1920:1/plain/images/products/1/5025/595923873/1.jpg@webp", "Varmilo Vintage Days CMYK V2 87", "15 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/4kMHg6KV1GY/rs:fit:1920:1920:1/plain/images/products/1/7317/706280597/varmilo-beijing-opera-V2-87.jpg@webp", "Varmilo Beijing Opera V2 87", "17 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/NBiRx35d0Qc/rs:fit:1920:1920:1/plain/images/products/1/5797/596137637/%D0%B3%D0%BB%D0%B0%D0%B2%D0%BD%D0%B0%D1%8F.jpg@webp", "Varmilo Sea Melody V2 87", "15 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/FaSx3P7I-n0/rs:fit:1920:1920:1/plain/images/products/1/3294/653790430/1.jpg@webp", "Varmilo Minilo Eucalyptus VXH67 Hot-Swap", "13 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/RgpNJdLfuJk/rs:fit:1920:1920:1/plain/images/products/1/753/592855793/Keychron_K3_V2_RGB.jpg@webp", "Keychron K3 V2 RGB", "11 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/itEZG1DUFto/rs:fit:1920:1920:1/plain/images/products/1/4514/647926178/keychron-k3-pro-qmk.jpg@webp", "Keychron K3 Pro QMK/VIA", "12 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/jDDdcT7GRHw/rs:fit:1920:1920:1/plain/images/products/1/4080/735727600/1.jpg@webp", "Durgod K330W Ice Cream", "11 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/GBKjt0z66AU/rs:fit:1920:1920:1/plain/images/products/1/1697/592864929/Durgod_Fusion_Original.jpg@webp", "Durgod Fusion Original", "11 690 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/c8Jzw3wEhUo/rs:fit:1920:1920:1/plain/images/products/1/3069/592866301/Durgod_Fusion_Navigator.jpg@webp", "Durgod Fusion Navigator", "13 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/P2w23742YDg/rs:fit:1920:1920:1/plain/images/products/1/2808/592866040/Durgod_Fusion_Steam.jpg@webp", "Durgod Fusion Steam", "13 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/V_ZUvn3HGg8/rs:fit:1920:1920:1/plain/images/products/1/3621/685837861/Halo65.jpg@webp", "NuPhy Halo65 Matte Black", "15 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/DWXdViqS-Q8/rs:fit:1920:1920:1/plain/images/products/1/7771/598769243/1.jpg@webp", "NuPhy Air60", "13 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/25m1CsMNJ2s/rs:fit:1920:1920:1/plain/images/products/1/3390/719359294/1__2_.jpg@webp", "NuPhy Halo75 Matte Black", "17 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/kWk6FOodnv0/rs:fit:1920:1920:1/plain/images/products/1/7819/736894603/1.jpg@webp", "Leopold FC650M Double Space BT Gray", "14 490 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/F3wfrNacEz0/rs:fit:1920:1920:1/plain/images/products/1/4247/634097815/1.jpg@webp", "Ducky One 3 Mini Yellow", "13 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/_5pGENlbc8s/rs:fit:1920:1920:1/plain/images/products/1/7381/675232981/ducky-sf-mist-4.jpg@webp", "Ducky One 3 SF Mist", "15 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/iSv5pXUWgYU/rs:fit:1920:1920:1/plain/images/products/1/6767/675232367/ducky-mini-front-min.jpg@webp", "Ducky One 3 Mini Cosmic", "13 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/pMzhTuEjeYY/rs:fit:1920:1920:1/plain/images/products/1/6223/675231823/ducky-mini-mist-3.jpg@webp", "Ducky One 3 Mini Mist", "13 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/qIir7l_45ig/rs:fit:1920:1920:1/plain/images/products/1/6226/672077906/12.jpg@webp", "Varmilo Shurikey Saizo 002", "15 990 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/PfSSNLQ4RLc/rs:fit:1920:1920:1/plain/images/products/1/5181/505943101/1_SHURIKEY_HANZO_001.jpg@webp", "Varmilo Shurikey Hanzo 001", "14 690 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/FAFf2pX_TBU/rs:fit:1920:1920:1/plain/images/products/1/7470/506281262/1_SHURIKEY_HANZO_003.jpg@webp", "Varmilo Shurikey Hanzo 003", "14 690 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/fyLlZuL3RP0/rs:fit:1920:1920:1/plain/images/products/1/2218/515680426/1_.jpg@webp", "Mistel MD600 V3 RGB", "17 480 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/eDgjc1e8LYY/rs:fit:1920:1920:1/plain/images/products/1/3101/467717149/1.jpg@webp", "Realforce R2 TenKeyless BlueGray APC", "35 290 ₽"));
  list.add(Product("https://static.insales-cdn.com/r/xYbiL4cGkJc/rs:fit:1920:1920:1/plain/images/products/1/3197/467717245/2.jpg@webp", "Realforce R2 TenKeyless Ivory", "35 290 ₽"));
  return list;
}