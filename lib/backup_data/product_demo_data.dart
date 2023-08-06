import 'package:diacritic/diacritic.dart';

class ProductDemoData {
  final String title;
  final String type;
  final String description;
  final String author;
  final String publisher;
  final String publishingYear;
  final double price;
  final double discount;
  // late int star;
  // late int totalSold;
  // late String key;
  final String images;

  ProductDemoData({
    required this.title,
    required this.type,
    required this.description,
    required this.author,
    required this.publisher,
    required this.publishingYear,
    required this.price,
    required this.discount,
    required this.images,
  });
  //  {
  //   star = 0;
  //   totalSold = 0;
  //   //key = removeDiacritics('$title $author').toLowerCase();
  // }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'description': description,
      'author': author,
      'publisher': publisher,
      'publishingYear': publishingYear,
      'price': price,
      'discount': discount,
      'star': 0,
      'totalSold': 0,
      'searchKey': removeDiacritics('$title $author').toLowerCase(),
      'images': images,
    };
  }

  static List<ProductDemoData> demoBt002Datas = [
    ProductDemoData(
      title: 'Chưa Kịp Lớn Đã Trưởng Thành (Tái Bản 2023)',
      type: 'bt002',
      description:
          'Chưa Kịp Lớn Đã Trưởng Thành\n\nChúng ta của hiện tại, đều chưa kịp lớn đã phải trưởng thành.\n\nLúc còn nhỏ có thể khóc cười tuỳ ý. Trưởng thành rồi mới biết hành động cũng cần nhìn sắc mặt người khác.\n\nLúc còn nhỏ có thể sống vô tư, vô lo. Trưởng thành rồi mới biết nếu chậm chân hơn người khác, chắc chắn sẽ bị đào thải bất cứ lúc nào.\n\nLúc còn nhỏ có thể khao khát, mơ mộng. Trưởng thành rồi mới biết thế giới ngoài kia thực sự rất tàn khốc.\n\nChúng ta đều giống nhau, lúc còn nhỏ đều khao khát trưởng thành. Trưởng thành rồi lại loay hoay học cách trở thành người lớn.\n\nNếu bạn đang trải qua giai đoạn lạc lõng và cô đơn như vậy, hãy để “Chưa kịp lớn đã phải trưởng thành” làm một người bạn ở bên, xoa dịu tổn thương và gửi tặng bạn đôi điều khích lệ. Mỗi trang sách đều là một lá thư nhắn nhủ bạn về sự đặc biệt của bản thân, về những nỗ lực hoàn thiện không ngừng nghỉ trong thế giới của người trưởng thành.\n\nCầm trên tay cuốn sách này, bạn sẽ hiểu rằng: quá trình trưởng thành nào cũng đều có kì vọng và nuối tiếc nhưng con người luôn phải học cách vượt qua mơ hồ, gạt đi mộng tưởng mà lớn lên.\n\nGấp lại “Chưa kịp lớn đã phải trưởng thành”, mong bạn trở thành phiên bản hoàn hảo nhất để kịp trải nghiệm và tận hưởng khoảnh khắc của tuổi trẻ. Mong bạn bản lĩnh bước đi, có được tương lai mà mình mong muốn, càng mong bạn có được cuộc đời bình thản an nhiên.\n\nVà phần còn lại của tuổi trẻ, mong bạn sẽ thực sự hạnh phúc.',
      author: 'Tớ Là Mây',
      publisher: 'NXB Dân Trí',
      publishingYear: '2023',
      price: 79000,
      discount: 0.25,
      images: 'book_dx001',
    ),
    ProductDemoData(
      title: 'Những Đứa Trẻ Đường Tàu',
      type: 'bt002',
      description:
          'Được xuất bản lần đầu vào năm 1906, sau hơn một thế kỉ ra mắt, “Những đứa trẻ đường tàu” của E. Nesbit vẫn luôn là một tượng đài tác phẩm thiếu nhi kinh điển không thể bỏ qua, một viên ngọc sáng mãi trong kí ức nhiều độc giả thế giới. Từng chi tiết cứ như đường ray tàu rẽ ra nhiều lối, làm người đọc không khỏi hồi hộp, và có cả những pha thót tim. Tính nhân văn được đề cao và được hướng ra từ tác phẩm một cách nhẹ nhàng, tinh tế, không hề bị gán bởi thuyết giáo hay gượng gạo. Cách kể cũng như cách tả khiến người đọc từ từ hình dung và đi vào câu chuyện, cảm nhận nó một cách thấm thía. Để rồi chìm đắm, say sưa bởi tâm hồn vô cùng đáng yêu và tinh nghịch của lũ trẻ với nỗi niềm ngập tràn hạnh phúc. Tôi cảm thấy ấm áp biết bao khi đọc được kết truyện. Nó làm tôi lặng mình suy nghĩ bởi những ngôn từ cô đọng và ý nghĩa vô cùng sâu sắc. Hẳn là độc giả nào cũng phải mỉm cười mãn nguyện khi gấp cuốn sách lại.\n\nNó không bi kịch, đau đớn như nỗi buồn mà hằng ngày bọn trẻ đã thầm chịu đựng mà mở ra một hướng kết khiến người đọc thỏa lòng. Bao nhiêu ước mơ bọn trẻ gửi gắm bấy lâu nay hay sự mong chờ được gặp cha đều được hội tụ ở kết truyện đầy ý nghĩa. Tôi chắc chắn rằng, khi đọc xong tác phẩm, các bạn sẽ thay đổi suy nghĩ của mình về cuộc sống và con người thực sự ở xung quanh. Nó cũng là bài học giáo dục con người ta cách sống đẹp, sự cho đi và nhận lại vẫn luôn tồn tại đồng thời. Chỉ là ta chưa nhận ra hết và thông suốt mà thôi. Những thông điệp từ truyện cũng giúp chúng ta tìm lại cách sống bản năng của mỗi con người: chấp nhận, yêu thương và tin tưởng dẫu rằng có gặp phải lắm biến cố đến thế nào. Vấp ngã, khổ đau đâu phải để xóa bỏ sự tồn tại của con người mà nó là tiền đề, là điều kiện để chúng ta có thể trưởng thành và chín chắn hơn trong cả suy nghĩ và hành động. Tôi và bạn, tất cả chúng ta đều cần điều đó. Nó cũng là lí do tôi khuyên bạn nên thử trải nghiệm cuốn sách này. Chắc chắn đó sẽ là trải nghiệm thú vị.',
      author: 'E Nesbit',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2021',
      price: 72000,
      discount: 0.15,
      images: 'book_dx002',
    ),
    ProductDemoData(
      title: 'Nhà Giả Kim (Tái Bản 2020)',
      type: 'bt002',
      description:
          'Tất cả những trải nghiệm trong chuyến phiêu du theo đuổi vận mệnh của mình đã giúp Santiago thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người. \n\nTiểu thuyết Nhà giả kim của Paulo Coelho như một câu chuyện cổ tích giản dị, nhân ái, giàu chất thơ, thấm đẫm những minh triết huyền bí của phương Đông. Trong lần xuất bản đầu tiên tại Brazil vào năm 1988, sách chỉ bán được 900 bản. Nhưng, với số phận đặc biệt của cuốn sách dành cho toàn nhân loại, vượt ra ngoài biên giới quốc gia, Nhà giả kim đã làm rung động hàng triệu tâm hồn, trở thành một trong những cuốn sách bán chạy nhất mọi thời đại, và có thể làm thay đổi cuộc đời người đọc.\n\n“Nhưng nhà luyện kim đan không quan tâm mấy đến những điều ấy. Ông đã từng thấy nhiều người đến rồi đi, trong khi ốc đảo và sa mạc vẫn là ốc đảo và sa mạc. Ông đã thấy vua chúa và kẻ ăn xin đi qua biển cát này, cái biển cát thường xuyên thay hình đổi dạng vì gió thổi nhưng vẫn mãi mãi là biển cát mà ông đã biết từ thuở nhỏ. Tuy vậy, tự đáy lòng mình, ông không thể không cảm thấy vui trước hạnh phúc của mỗi người lữ khách, sau bao ngày chỉ có cát vàng với trời xanh nay được thấy chà là xanh tươi hiện ra trước mắt. ‘Có thể Thượng đế tạo ra sa mạc chỉ để cho con người biết quý trọng cây chà là,’ ông nghĩ.”\n\n- Trích Nhà giả kim',
      author: 'Paulo Coelho',
      publisher: 'NXB Hội Nhà Văn',
      publishingYear: '2020',
      price: 79000,
      discount: 0.25,
      images: 'book_dx003',
    ),
    ProductDemoData(
      title: 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh (Bản In Mới - 2018)',
      type: 'bt002',
      description:
          'Những câu chuyện nhỏ xảy ra ở một ngôi làng nhỏ: chuyện người, chuyện cóc, chuyện ma, chuyện công chúa và hoàng tử , rồi chuyện đói ăn, cháy nhà, lụt lội,... Bối cảnh là trường học, nhà trong xóm, bãi tha ma. Dẫn chuyện là cậu bé 15 tuổi tên Thiều. Thiều có chú ruột là chú Đàn, có bạn thân là cô bé Mận. Nhưng nhân vật đáng yêu nhất lại là Tường, em trai Thiều, một cậu bé học không giỏi. Thiều, Tường và những đứa trẻ sống trong cùng một làng, học cùng một trường, có biết bao chuyện chung. Chúng nô đùa, cãi cọ rồi yêu thương nhau, cùng lớn lên theo năm tháng, trải qua bao sự kiện biến cố của cuộc đời.\nTác giả vẫn giữ cách kể chuyện bằng chính giọng trong sáng hồn nhiên của trẻ con. 81 chương ngắn là 81 câu chuyện hấp dẫn với nhiều chi tiết thú vị, cảm động, có những tình tiết bất ngờ, từ đó lộ rõ tính cách người. Cuốn sách, vì thế, có sức ám ảnh.',
      author: 'Nguyễn Nhật Ánh',
      publisher: 'NXB Trẻ',
      publishingYear: '2018',
      price: 125000,
      discount: 0.25,
      images: 'book_dx004',
    ),
    ProductDemoData(
      title: 'Có Một Ngày, Bố Mẹ Sẽ Già Đi',
      type: 'bt002',
      description:
          'Càng lớn lên, những quyến luyến của chúng ta đối với bố mẹ càng ít. Khi đại bàng non có thể giương cánh, nó luôn hướng tới không trung, chứ không phải rúc vào đôi cánh bố mẹ.\n\nBạn khát vọng cuộc sống khởi sắc, không còn quẫn bách giật gấu vá vai. Bạn khát vọng sự nghiệp tiến triển, như thế mới không uổng bao năm vất vả tăng ca bất kể gió mưa. Bạn khát vọng con cái của mình về sau có thể lớn lên vui vẻ khỏe mạnh, đạt được thành tích đáng tự hào, vươn lên trong môi trường cạnh tranh quyết liệt… Nhưng bạn lại vô tình đặt một khát vọng khác nằm sâu trong tâm hồn xuống vị trí dưới cùng, khát vọng này chính là hy vọng bố mẹ đừng vội già đi.\n\nGiống như mỗi ngày đều có thể nhìn thấy mặt trời, vào những ngày trời quang nắng đẹp, bạn cảm thấy ấm áp và dễ chịu, nó như một thứ đương nhiên nên có, hưởng thụ sự tốt đẹp nó mang lại đã trở thành thói quen của bạn. Nhưng nếu một ngày, có người nói với bạn mặt trời sẽ không mọc nữa, bạn cảm thấy thế nào? Có lẽ phần lớn mọi người đều cảm thấy sợ hãi và luống cuống. Bố mẹ cũng giống như mặt trời, luôn lặng lẽ ở sau lưng, cho bạn chỗ dựa và sự ấm áp, nhưng nếu một ngày bố mẹ không còn ở đấy nữa, cảm giác an toàn quen thuộc cũng lập tức biến mất, bấy giờ muốn tìm lại, sợ rằng đã quá muộn.\n\nBởi vì năm tháng vẫn mãi trôi, thời gian không trở lại, tên siêu trộm thời gian đang dần dần lấy đi tuổi xuân của bố mẹ, rồi có một ngày, bố mẹ sẽ già đi.',
      author: 'Nhiều Tác Giả',
      publisher: 'NXB Thế Giới',
      publishingYear: '2020',
      price: 96000,
      discount: 0.15,
      images: 'book_dx005',
    ),
    ProductDemoData(
      title: 'Cho Tôi Xin Một Vé Đi Tuổi Thơ (Bìa Mềm) (Tái Bản 2018)',
      type: 'bt002',
      description:
          'Trong Cho tôi xin một vé đi tuổi thơ, nhà văn Nguyễn Nhật Ánh mời người đọc lên chuyến tàu quay ngược trở lại thăm tuổi thơ và tình bạn dễ thương của 4 bạn nhỏ. Những trò chơi dễ thương thời bé, tính cách thật thà, thẳng thắn một cách thông minh và dại dột, những ước mơ tự do trong lòng… khiến cuốn sách có thể làm các bậc phụ huynh lo lắng rồi thở phào. Không chỉ thích hợp với người đọc trẻ, cuốn sách còn có thể hấp dẫn và thực sự có ích cho người lớn trong quan hệ với con mình.',
      author: 'Nguyễn Nhật Ánh',
      publisher: 'NXB Trẻ',
      publishingYear: '2018',
      price: 80000,
      discount: 0.25,
      images: 'book_dx006',
    ),
    ProductDemoData(
      title: 'Tôi Là Bêtô (Tái Bản 2018)',
      type: 'bt002',
      description:
          'Truyện Tôi là Bêtô là sáng tác mới nhất của nhà văn Nguyễn Nhật Ánh được viết theo phong cách hoàn toàn khác so với những tác phẩm trước đây của ông. Những mẩu chuyện, hay những phát hiện của chú chó Bêtô đầy thú vị, vừa hài hước, vừa chiêm nghiệm một cách nhẹ nhàng “vô vàn những điều thú vị mà cuộc sống cố tình giấu kín ở ngóc ngách nào đó trong tâm hồn của mỗi chúng ta”.',
      author: 'Nguyễn Nhật Ánh',
      publisher: 'NXB Trẻ',
      publishingYear: '2018',
      price: 85000,
      discount: 0.25,
      images: 'book_dx007',
    ),
    ProductDemoData(
      title:
          'Ra Bờ Suối Ngắm Hoa Kèn Hồng - Tặng Kèm Bookmark Bồi Hai Mặt + Thiệp Trái Tim In Bài Thơ Của Tác Giả',
      type: 'bt002',
      description:
          'Ra bờ suối ngắm hoa kèn hồng là tác phẩm trong trẻo, tràn đầy tình yêu thương mát lành, trải ra trước mắt người đọc khu vườn trại rực rỡ cỏ hoa của vùng quê thanh bình, kèm theo đó là những “nhân vật” đáng yêu, làm nên một “thế giới giàu có, rộng lớn và vô cùng hấp dẫn” mà dường như người lớn đã bỏ quên đâu đó từ lâu.\n\nSau Tôi là Bê Tô, Có hai con mèo ngồi bên cửa sổ, Con chó nhỏ mang giỏ hoa hồng, đây là một cuốn sách nữa của nhà văn Nguyễn Nhật Ánh mà nhân vật chính là những bé động vật ngộ nghĩnh, được mô tả sống động dưới ngòi bút tài hoa và giàu tình thương.\n\nCâu chuyện chạy qua 8 phần với 64 chương sách nhỏ đầy ắp lòng thương yêu, tính lương thiện, tình thân bạn bè, lòng dũng cảm và bao dung, đánh bạt sự ác độc và cả mọi thói xấu.\n\nKhép cuốn sách lại, tự nhiên thấy lòng mình dịu lắng, bình yên đến lạ lùng…',
      author: 'Nguyễn Nhật Ánh',
      publisher: 'NXB Trẻ',
      publishingYear: '2022',
      price: 145000,
      discount: 0.2,
      images: 'book_dx008',
    ),
    ProductDemoData(
      title:
          '999 Lá Thư Gửi Cho Chính Mình - Mong Bạn Trở Thành Phiên Bản Hạnh Phúc Nhất (Tập 2) - Tái Bản 2021',
      type: 'bt002',
      description:
          '“999 lá thư gửi cho chính mình” là một tác phẩm đặc biệt đầy cảm hứng đến từ tác giả văn học mạng nổi tiếng Miêu Công Tử, mang một màu sắc riêng biệt qua những lời thư nhỏ nhắn nhủ đến người đọc về giá trị cuộc sống, tình yêu, tuổi trẻ, tương lai… v.v..\n\nTiếp nối phần 1 giúp bạn trở nên hoàn hảo, cuốn sách phần 2: “999 lá thư gửi cho chính mình” – Mong bạn trở thành phiên bản hạnh phúc nhất, không chỉ một lần nữa khẳng định và nhắc nhở bạn rằng việc nỗ lực quan trọng đến mức nào mà bên cạnh đó còn đề cao những yếu tố không thể thiếu trong cuộc sống để bạn có thể trở nên hạnh phúc hơn, giúp bạn mỗi ngày như một hoa hướng dương hướng về phía mặt trời, hấp thụ trọn vẹn năng lượng tích cực, vui vẻ mỉm cười, mọi đau buồn sẽ bốc hơi tan biến.',
      author: 'Miêu Công Tử',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2022',
      price: 129000,
      discount: 0.15,
      images: 'book_dx009',
    ),
    ProductDemoData(
      title: 'Làm Bạn Với Bầu Trời - Tặng Kèm Khung Hình Xinh Xắn',
      type: 'bt002',
      description:
          'Một câu chuyện giản dị, chứa đầy bất ngờ cho tới trang cuối cùng. Và đẹp lộng lẫy, vì lòng vị tha và tình yêu thương, khiến mắt rưng rưng vì một nỗi mừng vui hân hoan. Cuốn sách như một đốm lửa thắp lên lòng khát khao sống tốt trên đời.\n\nViết về điều tốt đã không dễ, viết sao cho người đọc có thể đón nhận đầy cảm xúc tích cực, và muốn được hưởng, được làm những điều tốt dù nhỏ bé... mới thật là khó. Làm bạn với bầu trời của Nguyễn Nhật Ánh đã làm được điều này.\n\nNhư nhà văn từng phát biểu “...điểm mạnh của văn chương nằm ở khả năng thẩm thấu. Bằng hình thức đặc thù của mình, văn chương góp phần mài sắc các ý niệm đạo đức nơi người đọc một cách vô hình. Bồi đắp tâm hồn và nhân cách một cách âm thầm và bền bỉ, đó là chức năng gốc rễ của văn chương, đặc biệt là văn chương viết cho thanh thiếu niên.”',
      author: 'Nguyễn Nhật Ánh',
      publisher: 'NXB Trẻ',
      publishingYear: '2019',
      price: 110000,
      discount: 0.25,
      images: 'book_dx010',
    ),
    ProductDemoData(
      title: 'Cánh Đồng Bất Tận (Tái Bản 2019)',
      type: 'bt002',
      description:
          '"Cánh đồng bất tận" bao gồm những truyện hay và mới nhất của nhà văn Nguyễn Ngọc Tư. Đây là tác phẩm đang gây xôn xao trong đời sống văn học, bởi ở đó người ta tìm thấy sự dữ dội, khốc liệt của đời sống thôn dã qua cái nhìn của một cô gái. Bi kịch về nỗi mất mát, sự cô đơn được đẩy lên đến tận cùng, khiến người đọc có lúc cảm thấy nhói tim... NXB Trẻ trân trọng giới thiệu cùng bạn đọc.',
      author: 'Nguyễn Ngọc Tư',
      publisher: 'NXB Trẻ',
      publishingYear: '2021',
      price: 85000,
      discount: 0.15,
      images: 'book_dx011',
    ),
    ProductDemoData(
      title: 'Tuổi Trẻ Đáng Giá Bao Nhiêu (Tái Bản 2021)',
      type: 'bt002',
      description:
          '“Bạn hối tiếc vì không nắm bắt lấy một cơ hội nào đó, chẳng có ai phải mất ngủ.\n\nBạn trải qua những ngày tháng nhạt nhẽo với công việc bạn căm ghét, người ta chẳng hề bận lòng.\n\nBạn có chết mòn nơi xó tường với những ước mơ dang dở, đó không phải là việc của họ.\n\nSuy cho cùng, quyết định là ở bạn. Muốn có điều gì hay không là tùy bạn.\n\nNên hãy làm những điều bạn thích. Hãy đi theo tiếng nói trái tim. Hãy sống theo cách bạn cho là mình nên sống.\n\nVì sau tất cả, chẳng ai quan tâm.”\n\n“Tôi đã đọc quyển sách này một cách thích thú. Có nhiều kiến thức và kinh nghiệm hữu ích, những điều mới mẻ ngay cả với người gần trung niên như tôi.\n\nTuổi trẻ đáng giá bao nhiêu? được tác giả chia làm 3 phần: HỌC, LÀM, ĐI.\n\nNhưng tôi thấy cuốn sách còn thể hiện một phần thứ tư nữa, đó là ĐỌC.\n\nHãy đọc sách, nếu bạn đọc sách một cách bền bỉ, sẽ đến lúc bạn bị thôi thúc không ngừng bởi ý muốn viết nên cuốn sách của riêng mình.\n\nNếu tôi còn ở tuổi đôi mươi, hẳn là tôi sẽ đọc Tuổi trẻ đáng giá bao nhiêu? nhiều hơn một lần.”\n\n- Đặng Nguyễn Đông Vy, tác giả, nhà báo',
      author: 'Rosie Nguyễn',
      publisher: 'NXB Hội Nhà Văn',
      publishingYear: '2021',
      price: 90000,
      discount: 0.25,
      images: 'book_dx012',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 1',
      type: 'bt001',
      description:
          '1. Tiếng Việt lớp 1 - tập 1\n2. Tiếng Việt lớp 1 - tập 2\n3. Toán lớp 1\n4. Tự Nhiên và Xã Hội lớp 1\n5. Tập Viết lớp 1 – tập 1\n6. Tập Viết lớp 1 – tập 2\n7. Vở Bài Tập Tiếng Việt lớp 1 – tập 1\n8. Vở Bài Tập Tiếng Việt lớp 1 – tập 2\n9. Vở Bài tập Toán lớp 1 - tập 1\n10. Vở Bài tập Toán lớp 1 - tập 2\n11. Vở Bài tập Tự Nhiên và Xã Hội lớp 1\n12. Vở Bài tập Đạo đức lớp 1\n13. Tập Bài Hát lớp 1',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2019',
      price: 115000,
      discount: 0.15,
      images: 'sgk_bo_01',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 2',
      type: 'bt001',
      description: '',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2022',
      price: 105000,
      discount: 0.1,
      images: 'sgk_bo_02',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 3',
      type: 'bt001',
      description:
          '1. Tiếng Việt 3 - T.1\n2. Tiếng Việt 3 - T.2\n3. Toán 3\n4. Tự Nhiên Xã Hội 3\n5. Tập Viết 3 - T.1\n6. Tập Viết 3 - T.2',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2022',
      price: 58000,
      discount: 0.1,
      images: 'sgk_bo_03',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 4',
      type: 'bt001',
      description: '',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2021',
      price: 80000,
      discount: 0.15,
      images: 'sgk_bo_04',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 5',
      type: 'bt001',
      description:
          '1. Tiếng Việt 5/1\n2. Tiếng Việt 5/2\n3. Toán 5\n4. Khoa học 5\n5. Lịch Sử & Địa Lí 5\n6. Âm Nhạc 5\n7. Đạo đức 5\n8. Mĩ thuật 5\n9. Kĩ Thuật 5',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2023',
      price: 100000,
      discount: 0.1,
      images: 'sgk_bo_05',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 6',
      type: 'bt001',
      description: '',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2023',
      price: 137000,
      discount: 0.15,
      images: 'sgk_bo_06',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 7',
      type: 'bt001',
      description: '',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2019',
      price: 145000,
      discount: 0.15,
      images: 'sgk_bo_07',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 8',
      type: 'bt001',
      description:
          'Toán 8 - Tập 1\nToán 8 - Tập 2\nVật Lý 8\nHoá Học 8\nSinh 8\nCông Nghệ 8\nNgữ Văn 8 - Tập 1\nNgữ Văn 8 - Tập 2\nLịch Sử 8\nĐịa Lý 8\nGiáo Dục Công Dân 8\nÂm Nhạc và Mỹ Thuật 8\nTiếng Anh 8',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2022',
      price: 149000,
      discount: 0.15,
      images: 'sgk_bo_08',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 9',
      type: 'bt001',
      description:
          '1. Toán 9/1\n2. Toán 9/2\n3. Vật lí 9\n4. Hoá học 9\n5. Sinh học 9\n6. Ngữ văn 9/1\n7. Ngữ văn 9/2\n8. Lịch sử 9\n9. Địa lí 9\n10. Giáo dục công dân 9\n11. Tiếng Anh 9\n12. Âm nhạc và Mĩ thuật 9',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2021',
      price: 155000,
      discount: 0.1,
      images: 'sgk_bo_09',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 10',
      type: 'bt001',
      description:
          'Đại số 10\nHình học 10\nVật lí 10\nHóa học 10\nSinh học 10\nNgữ văn 10 (Tập 1)\nNgữ văn 10 (Tập 2)\nLịch sử 10\nĐịa lí 10\nTin học 10\nGiáo dục công dân 10\nCông nghệ 10\nTiếng Anh 10\nGiáo dục Quốc phòng 10',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2022',
      price: 125000,
      discount: 0.1,
      images: 'sgk_bo_10',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 11',
      type: 'bt001',
      description:
          'Đại số 11\nHinh hoc 11\nVật lý 11\nHóa Học 11\nSinh học 11\nNgữ văn 11 - Tập 1\nNgữ văn 11 - Tập 2\nLịch sử 11\nĐịa lý 11\nTiếng Anh 11\nCông nghệ 11\nCông dân 11\nTin học 11\nGD AN NINH Quốc Phòng',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2021',
      price: 175000,
      discount: 0.1,
      images: 'sgk_bo_11',
    ),
    ProductDemoData(
      title: 'Bộ sách giáo khoa lớp 12',
      type: 'bt001',
      description:
          'Giải tích  12\nHình hoc  12\nVật lý   12\nHóa học  12\nSinh học  12\nNgữ văn  12 - Tập 1\nNgữ văn  12 - Tập 2\nLịch sử  12\nĐịa lý  12\nTiếng Anh  12\nCông nghệ  12\nCông dân  12\nTin học  12\nGD An ninh Quốc Phòng',
      author: 'Nhiều Tác giả',
      publisher: 'NXB Giáo dục Việt Nam',
      publishingYear: '2021',
      price: 180000,
      discount: 0.15,
      images: 'sgk_bo_12',
    ),
    ProductDemoData(
      title: 'Conan Hoạt Hình Màu - Bài Thơ Tình Thẫm Đỏ - Tập 2',
      type: 'bt003',
      description:
          'Vụ sát hại nhà vô địch Cúp Satsuki ở Kyoto và vụ đánh bom Đài truyền hình ở Osaka xảy ra gần như cùng lúc… Cả hai đều chưa rõ hung thủ cũng như mục đích gây án!!Tuy nhiên, theo suy luận của Conan và Heiji, “Hội Satsuki” có liên quan đến cả hai vụ này!!\n\nKhi những khúc ngâm Bách Nhân Nhất Thủ của Hội trưởng Hội Satsuki còn đang vang vọng, một vụ án bất ngờ lại xảy ra!!\n\nBị bửa vây bởi muôn trùng lửa đỏ suốt thời gian dài, giờ đây, Conan và Heiji sắp tới gần chân tưởng của vụ án!! Cuộc đấu vì tình yêu giữa Kazuha và Momiji sẽ diễn biến ra sao!?',
      author: 'Gosho Aoyama, Takahiro Okura',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2020',
      price: 50000,
      discount: 0.1,
      images: 'conan_dx001',
    ),
    ProductDemoData(
      title:
          'Thám Tử Lừng Danh Conan Hoạt Hình Màu: Mê Cung Trong Thành Phố Cổ - Tập 2',
      type: 'bt003',
      description:
          'Thám Tử Lừng Danh Conan Hoạt Hình Màu: Mê Cung Trong Thành Phố Cổ - Tập 2\n\nVụ án giết người hàng loạt xảy ra ở 3 thành phố Tokyo, Osaka, Kyoto. Để làm sáng tỏ vụ án, Conan và Heiji đã tức tốc đến Kyoto! Đúng lúc ấy, một nhân vật bí ẩn được cho là thủ\n\nphạm đã xuất hiện trước mặt hai người!! Chân tướngcủa vụ án nổi lên một cách đáng ngờ dưới gốc cây anh đào trong đêm!!',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2020',
      price: 60000,
      discount: 0.1,
      images: 'conan_dx002',
    ),
    ProductDemoData(
      title:
          'Thám Tử Lừng Danh Conan Hoạt Hình Màu: 15 Phút Trầm Mặc - Tập 1 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Một bức thư đe dọa đã gửi tới ngài Asakura - thị trưởng thành phố Tokyo. Ngày hôm sau, đoạn hầm chui đã bị nổ tung khi chuyến tàu khai trương chở ngài thị trưởng vừa chạy tới.\n\nBiết được thông tin về lá thư khủng bố, Conan đã làm hết sức mình để ngăn chặn thảm họa diễn ra ngay trước mắt.\n\nVụ việc này dường như có mối liên hệ với một vụ tai nạn giao thông xảy ra tại khu làng tái định cư công trình đập thủy điện 8 năm về trước.\n\nCậu thiếu niên bị mất trí nhớ tên Tachihara Touma dường như là một mắt xích quan trọng trong vụ án lần này…',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 60000,
      discount: 0.1,
      images: 'conan_dx003',
    ),
    ProductDemoData(
      title:
          'Thám Tử Lừng Danh Conan Hoạt Hình Màu: 15 Phút Trầm Mặc - Tập 2 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Một bức thư đe dọa đã gửi tới ngài Asakura - thị trưởng thành phố Tokyo. Ngày hôm sau, đoạn hầm chui đã bị nổ tung khi chuyến tàu khai trương chở ngài thị trưởng vừa chạy tới.\n\nBiết được thông tin về lá thư khủng bố, Conan đã làm hết sức mình để ngăn chặn thảm họa diễn ra ngay trước mắt.\n\nVụ việc này dường như có mối liên hệ với một vụ tai nạn giao thông xảy ra tại khu làng tái định cư công trình đập thủy điện 8 năm về trước.\n\nCậu thiếu niên bị mất trí nhớ tên Tachihara Touma dường như là một mắt xích quan trọng trong vụ án lần này…',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 60000,
      discount: 0.1,
      images: 'conan_dx004',
    ),
    ProductDemoData(
      title:
          'Thám Tử Lừng Danh Conan - Tuyển Tập Fan Bình Chọn - Tập 1 + 2 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Tuyển tập những vụ án trong "Thám tử lừng danh Conan", được các độc giả bình chọn nhiều nhất như: "Vụ án 12 triệu con tim chấn động Sở cảnh sát", "Sự hồi phục liều mạng" với vở kịch trong Lễ hội Văn hóa - Kị sĩ đeo Mặt nạ, "Trận giáp lá cà với Tổ chức Áo Đen, hai vụ án trong đêm trăng tròn", nhữngbí ẩn về Jodie và Akai xuất hiện trong truyện suốt một thời gian dài đến đây đã được làm sáng tỏ, "Vụ án Kudo Shinichi ở New York"... sẽ làm hài lòng những ai yêu mến "Viên đạn bạc" - chàng thám tử Conan/Shinichi!',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 70000,
      discount: 0.1,
      images: 'conan_dx005',
    ),
    ProductDemoData(
      title:
          'Thám Tử Lừng Danh Conan - Tuyển Tập Đặc Biệt: Những Câu Chuyện Lãng Mạn Tập 1 + 2 + 3 (Tái Bản 2020)',
      type: 'bt003',
      description:
          'Cuốn sách này tuyển tập những câu chuyện lãng mạn giữa Conan (Shinichi) và Ran do đích thân tác giả Gosho Aoyama tuyển chọn. Các bạn hãy theo dõi câu chuyện ngọt ngào giữa hai người họ nhé.',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2020',
      price: 150000,
      discount: 0.15,
      images: 'conan_dx006',
    ),
    ProductDemoData(
      title: 'Thám Tử Lừng Danh Conan - Tập 98 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Sera Masumi tiếp tục thăm dò Haibara Ai và ở thế đối đầu với Okiya Subaru!\n\nTrong khi đó, Conan đã tiến đến gần chân tưởng của “em gái ngoài lãnh địa” - Mary…!?\n\nHaneda Shukichi bất ngờ gặp án mạng tại buổi học nhóm shogi! Vụ án diễn biến bất ngờ với nhiều khúc ngoặt để rồi cuối cùng, Akai Shuichi xuất hiện…!? Không dừng lại ở đó, tập 98 còn mang tới vụ án giải mật mã của một người giúp việc, nơi cuộc đua phá án giữa Conan và Heiji đã khởi phát từ mưu kế của Ooka Momiji!!',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 25000,
      discount: 0.1,
      images: 'conan_dx007',
    ),
    ProductDemoData(
      title: 'Thám Tử Lừng Danh Conan - Tập 100 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Những thi thể không rõ danh tính liên tục được phát hiện… Thủ phạm là tổ chức Áo đen.\n\nĐối thủ là Gin, Vodka, Chianti, Korn, Vermouth, Kir, và RUM. Kết thúc cuộc đấu trí cân tài cân sức ấy, sự thật được đưa ra ánh sáng là…',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 25000,
      discount: 0.1,
      images: 'conan_dx008',
    ),
    ProductDemoData(
      title: 'Thám Tử Lừng Danh Conan - Tập 99 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Chuyện gì đã xảy ra trên cầu Vauxhall ở London…?\n\nBí ẩn bao trùm hai mẹ con Mary và Masumi Sera sẽ được làm sáng tỏ trong chương phá giải vụ án đầu độc tại bữa tiệc của người mẫu!\n\nTìm đến nơi Kazami đang lâm nạn, Toru Amuro tình cờ gặp Conan và nhóm thám tử nhí rồi bước vào vụ án giam cầm ở trang trại chăn nuôi! Tại đây, anh cũng chạm trán Rumi Wakasa - người đã dẫn bọn trẻ tới…!?',
      author: 'Gosho Aoyama',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 25000,
      discount: 0.1,
      images: 'conan_dx009',
    ),
    ProductDemoData(
      title:
          'Thám Tử Lừng Danh Conan - Tiểu Thuyết - Hoa Hướng Dương Trong Biển Lửa',
      type: 'bt003',
      description:
          '“Chết tiệt!”\n\nShinichi vận hết sức lay thanh sắt. “Nếu không nhanh lên thì chẳng những bức tranh mà cả mình cũng sẽ…”\n\nThế nhưng, dù thử đủ cách, cậu không thể nạy được cây cọc nằm lèn chặt giữa tường phòng và bức tranh. Cậu thở khó nhọc. Sau lưng cậu vang lên tiếng gạch vụn lộp độp rơi. Phòng triển lãm chìm trong khói bụi, ngọn lửa đã đuổi sát nút.\n\n“Kid!” Đột nhiên, một tiếng gọi vang lên.\n\nKhi quay đầu lại, cậu nhìn thấy Conan chạy vào phòng.\n\nTập đoàn Suzuki đấu giá thành công kiệt tác Hoa hướng dương mộng ảo tưởng chừng thất lạc của danh họa van Gogh với số tiền kỉ lục và dự định tổ chức một triển lãm vô tiền khoáng hậu. Không ngờ, tai họa kinh hoàng liên tiếp giáng xuống bức tranh có số phận chìm nổi cùng những người liên quan. Bí ẩn đằng sau bức họa là gì? Danh tính kẻ thủ ác liệu có được vạch trần?',
      author: 'Gosho Aoyama, Takeharu Sakurai, Shima Mizuki',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2021',
      price: 50000,
      discount: 0.05,
      images: 'conan_dx010',
    ),
    ProductDemoData(
      title:
          'Doraemon Truyện Dài - Tập 18 - Nobita Du Hành Biển Phương Nam (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Mỗi tập truyện là một cuộc phưu lưu khám phá những chân trời mới lạ. Hãy để trí tưởng tượng của bạn bay bổng cùng nhóm bạn Doraemon, Nobita, Shizuka, Jaian, Suneo đến các vùng đất xa xôi, kì bí và cảm nhận những khoảnh khắc tình bạn tươi đẹp của cuộc đời!\n24 tập Doraemon truyện dài phiên bản mới với nội dung và hình thức trung thành với nguyên tác của hoạ sĩ Fujiko.F.Fujio kể về 24 chuyến phiêu lưu của nhóm bạn. Những bảo bối trong chiếc túi thần kỳ của Doraemon đã biến những điều không thể thành có thể, biến ước mơ thành hiện thực.\nNhững chuyến phiêu lưu không bị hạn chế bởi không gian và thời gian. Đó là chuyến du hành vượt qua thời gian trở về thời tiền sử của vũ trụ (Nobita và lịch sử khai phá vũ trụ), của trái đất (Chú khủng long của Nobita), của nước Nhật (Nobita và nước Nhật thời nguyên thủy), đến tương lai (Nobita và cuộc phiêu lưu ở thành phố dây cót, Nobita và vương quốc robot)... 24 chuyến phiêu lưu của nhóm bạn có đích đến là 24 địa điểm kỳ thú, chỉ có trí tưởng tượng và ước mơ có thể vươn tới (Nobita và hành tinh muông thú, Nobita và chuyến du hành xứ quỷ...).\nNhững câu chuyện về chú mèo máy thông minh Doraemon và các bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi đưa độc giả bước vào thế giới hồn nhiên, trong sáng, đầy ắp tiếng cười với một kho bảo bối biến ước mơ thành sự thật. Doraemon chính là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx001',
    ),
    ProductDemoData(
      title:
          'Doraemon Truyện Dài - Tập 14 - Nobita Và Ba Chàng Hiệp Sĩ Mộng Mơ (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Lần này, nhóm bạn Nobita sẽ trở thành những chàng hiệp sĩ trong thế giới mộng mơ và chiến đấu vô cùng anh dũng.\n\nThế giới mộng mơ đang bị bọn yêu quái tà ma thống trị… Liệu Nobita và các bạn có tiêu diệt được binh đoàn yêu ma để đem lại sự bình yên cho thế giới này hay không… chúng ta cùng theo dõi nhé!',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx002',
    ),
    ProductDemoData(
      title:
          'Doraemon Truyện Dài - Tập 24 - Nobita Ở Vương Quốc Chó Mèo (Tái Bản 2019)',
      type: 'bt003',
      description:
          'Mỗi tập truyện là một cuộc phưu lưu khám phá những chân trời mới lạ. Hãy để trí tưởng tượng của bạn bay bổng cùng nhóm bạn Doraemon, Nobita, Shizuka, Jaian, Suneo đến các vùng đất xa xôi, kì bí và cảm nhận những khoảnh khắc tình bạn tươi đẹp của cuộc đời!\n24 tập Doraemon truyện dài phiên bản mới với nội dung và hình thức trung thành với nguyên tác của hoạ sĩ Fujiko.F.Fujio kể về 24 chuyến phiêu lưu của nhóm bạn. Những bảo bối trong chiếc túi thần kỳ của Doraemon đã biến những điều không thể thành có thể, biến ước mơ thành hiện thực.\nNhững chuyến phiêu lưu không bị hạn chế bởi không gian và thời gian. Đó là chuyến du hành vượt qua thời gian trở về thời tiền sử của vũ trụ (Nobita và lịch sử khai phá vũ trụ), của trái đất (Chú khủng long của Nobita), của nước Nhật (Nobita và nước Nhật thời nguyên thủy), đến tương lai (Nobita và cuộc phiêu lưu ở thành phố dây cót, Nobita và vương quốc robot)... 24 chuyến phiêu lưu của nhóm bạn có đích đến là 24 địa điểm kỳ thú, chỉ có trí tưởng tượng và ước mơ có thể vươn tới (Nobita và hành tinh muông thú, Nobita và chuyến du hành xứ quỷ...).\nNhững câu chuyện về chú mèo máy thông minh Doraemon và các bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi đưa độc giả bước vào thế giới hồn nhiên, trong sáng, đầy ắp tiếng cười với một kho bảo bối biến ước mơ thành sự thật. Doraemon chính là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2019',
      price: 18000,
      discount: 0.1,
      images: 'doraemon_dx003',
    ),
    ProductDemoData(
      title:
          'Doraemon Truyện Dài - Tập 2 - Nobita Và Lịch Sử Khai Phá Vũ Trụ (Tái Bản 2023)',
      type: 'bt003',
      description:
          '“Nobita và lịch sử khai phá vũ trụ” là tác phẩm thứ 2 trong xêri Doraemon truyện dài, và cũng đã được chuyển thể thành phim hoạt hình.\n\nỞ trên trái đất, Nobita hậu đậu làm việc gì cũng thất bại, nhưng khi đến hành tinh Koyakoya nơi lực hút rất yếu thì cậu bỗng trở nên mạnh mẽ phi thường. Bằng sức mạnh ấy, Nobita đã chiến đấu với bọn người xấu để bảo vệ hòa bình cho hành tinh này. Tập truyện sẽ đưa chúng ta bước vào vũ trụ bao la rộng lớn, và chắc chắn các em sẽ vô cùng cảm động trước những hành động dũng cảm của Nobita, Doraemon cùng các bạn!',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx004',
    ),
    ProductDemoData(
      title:
          'Doraemon Truyện Dài - Tập 8 - Nobita Và Hiệp Sĩ Rồng (Tái Bản 2019)',
      type: 'bt003',
      description:
          'Đây là câu chuyện về cuộc phiêu lưu thần kì của nhóm bạn Nobita tới thế giới bí ẩn trong lòng đất.\nNơi họ tới chính là vương quốc của khủng long do những người lòng đất thống trị… Điều gì đang đợi Nobita và các ban?... Chúng ta hãy cùng hồi hộp theo dõi nhé!',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2019',
      price: 18000,
      discount: 0.1,
      images: 'doraemon_dx005',
    ),
    ProductDemoData(
      title:
          'Doraemon Tập 23 - Nobita Và Những Pháp Sư Gió Bí Ẩn (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Mỗi tập truyện là một cuộc phưu lưu khám phá những chân trời mới lạ. Hãy để trí tưởng tượng của bạn bay bổng cùng nhóm bạn Doraemon, Nobita, Shizuka, Jaian, Suneo đến các vùng đất xa xôi, kì bí và cảm nhận những khoảnh khắc tình bạn tươi đẹp của cuộc đời!\n24 tập Doraemon truyện dài phiên bản mới với nội dung và hình thức trung thành với nguyên tác của hoạ sĩ Fujiko.F.Fujio kể về 24 chuyến phiêu lưu của nhóm bạn. Những bảo bối trong chiếc túi thần kỳ của Doraemon đã biến những điều không thể thành có thể, biến ước mơ thành hiện thực.\nNhững chuyến phiêu lưu không bị hạn chế bởi không gian và thời gian. Đó là chuyến du hành vượt qua thời gian trở về thời tiền sử của vũ trụ (Nobita và lịch sử khai phá vũ trụ), của trái đất (Chú khủng long của Nobita), của nước Nhật (Nobita và nước Nhật thời nguyên thủy), đến tương lai (Nobita và cuộc phiêu lưu ở thành phố dây cót, Nobita và vương quốc robot)... 24 chuyến phiêu lưu của nhóm bạn có đích đến là 24 địa điểm kỳ thú, chỉ có trí tưởng tượng và ước mơ có thể vươn tới (Nobita và hành tinh muông thú, Nobita và chuyến du hành xứ quỷ...).\nNhững câu chuyện về chú mèo máy thông minh Doraemon và các bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi đưa độc giả bước vào thế giới hồn nhiên, trong sáng, đầy ắp tiếng cười với một kho bảo bối biến ước mơ thành sự thật. Doraemon chính là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx006',
    ),
    ProductDemoData(
      title: 'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 45 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx007',
    ),
    ProductDemoData(
      title: 'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 34 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx008',
    ),
    ProductDemoData(
      title: 'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 38 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx009',
    ),
    ProductDemoData(
      title: 'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 32 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.',
      author: 'Fujiko F Fujio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 22000,
      discount: 0.1,
      images: 'doraemon_dx010',
    ),
    ProductDemoData(
      title: 'Shin Cậu Bé Bút Chì - Đặc Biệt Tập 1 (Tái Bản 2019)',
      type: 'bt003',
      description:
          'Crayon Shin-chan (tên tiếng Việt: Shin-cậu bé bút chì) của tác giả Yoshito Usui là một trong những bộ manga nổi tiếng của Nhật Bản. Sau khi tập 50 được xuất bản tại Nhật vào năm 2010, tác giả tiếp tục đăng tải những mẩu truyện ngắn đầy thú vị xoay quanh nhân vật chính, cậu bé Shin tinh nghịch đáng yêu, lên nguyệt san Town Manga. Và cuốn Shin đặc biệt này tập hợp 21 mẩu truyện ngắn đã được đăng trong 2 năm đó.\nVậy Shin - Cậu bé bút chì đặc biệt này có gì khác so với bộ thường mà nhà xuất bản đang gửi tới bạn đọc?\nĐiều đầu tiên, chắc các bạn cũng biết, đó là bộ đặc biệt này sẽ được phát hành đồng thời với bên Nhật. Tức là không phải chờ lâu mới được cầm trên tay cuốn truyện hài hước mà các bạn đang mong chờ, các otaku (fan truyện tranh) bên Nhật được cầm trên tay cuốn đặc biệt lúc nào, các bạn cũng được sở hữu nó ngay lúc đó.\nĐiều thứ hai, mỗi chương trong tác phẩm này là một câu chuyện riêng biệt, với chiều dài từ 4 đến 5 trang. Vô cùng ngắn gọn mà hài hước, mỗi câu chuyện lại mang đến cho ta những tràng cười, cũng như những bài học thú vị khác nhau.\nTiếp tục đáp ứng nhu cầu của độc giả yêu thích bộ truyện, nhà xuất bản xin gửi tới các bạn tập đầu tiên trong bộ Shin-cậu bé bút chì đặc biệt này. Hi vọng rằng các bạn sẽ ủng hộ cuốn truyện nhiệt tình như với bộ Shin thường kì cũng như phần nào hiểu được ý nghĩa nhân văn và thông điệp mà nhà xuất bản gửi gắm tới các bạn độc giả thân yêu.',
      author: 'Yoshito Usui, UY Studio',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2019',
      price: 19000,
      discount: 0.1,
      images: 'shin_dx001',
    ),
    ProductDemoData(
      title: 'Shin - Cậu Bé Bút Chì - Tập 34 (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Được phát hành lần đầu vào năm 1992, bộ truyện sớm gây được tiếng vang đối với độc giả Nhật Bản và nhiều nước khác trên thế giới. Vài năm sau đó, loạt phim hoạt hình về cậu bé Shin cũng được sản xuất và phát sóng liên tục cho đến bây giờ.\n\nVề hình thức thể hiện, tác giả sử dụng bút pháp đơn giản, thậm chí có vẻ "ngây ngô" hơn so với các bộ manga khác. Nội dung truyện cũng đơn giản: tất cả xoay quanh nhân vật chính là cậu bé Shin 5 tuổi với những mối quan hệ thân-sơ, bố mẹ, hàng xóm, thầy cô, bạn bè, người quen và... cả những người không quen.',
      author: 'Yoshito Usui',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 25000,
      discount: 0.1,
      images: 'shin_dx002',
    ),
    ProductDemoData(
      title:
          'Shin - Cậu Bé Bút Chì - Phiên Bản Hoạt Hình Màu - Tập 48: Vui Lên Nào Bố Ơi! (Tái Bản 2023)',
      type: 'bt003',
      description:
          'Được phát hành lần đầu vào năm 1992, bộ truyện sớm gây được tiếng vang đối với độc giả Nhật Bản và nhiều nước khác trên thế giới. Vài năm sau đó, loạt phim hoạt hình về cậu bé Shin cũng được sản xuất và phát sóng liên tục cho đến bây giờ.\n\nVề hình thức thể hiện, tác giả sử dụng bút pháp đơn giản, thậm chí có vẻ "ngây ngô" hơn so với các bộ manga khác. Nội dung truyện cũng đơn giản: tất cả xoay quanh nhân vật chính là cậu bé Shin 5 tuổi với những mối quan hệ thân-sơ, bố mẹ, hàng xóm, thầy cô, bạn bè, người quen và... cả những người không quen.',
      author: 'Yoshito Usui',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2023',
      price: 50000,
      discount: 0.1,
      images: 'shin_dx003',
    ),
    ProductDemoData(
      title: 'Nghĩ Giàu & Làm Giàu (Tái Bản 2020)',
      type: 'bt006',
      description:
          'Think and Grow Rich - Nghĩ giàu và làm giàu là một trong những cuốn sách bán chạy nhất mọi thời đại. Đã hơn 60 triệu bản được phát hành với gần trăm ngôn ngữ trên toàn thế giới và được công nhận là cuốn sách tạo ra nhiều triệu phú, một cuốn sách truyền cảm hứng thành công nhiều hơn bất cứ cuốn sách kinh doanh nào trong lịch sử.\nTác phẩm này đã giúp tác giả của nó, Napoleon Hill, được tôn vinh bằng danh hiệu “người tạo ra những nhà triệu phú”. Đây cũng là cuốn sách hiếm hoi được đứng trong top của rất nhiều bình chọn theo nhiều tiêu chí khác nhau - bình chọn của độc giả, của giới chuyên môn, của báo chí. Lý do để Think and Grow Rich - Nghĩ giàu và làm giàu có được vinh quang này thật hiển nhiên và dễ hiểu: Bằng việc đọc và áp dụng những phương pháp đơn giản, cô đọng này vào đời sống của mỗi cá nhân mà đã có hàng ngàn người trên thế giới trở thành triệu phú và thành công bền vững.\nĐiều thú vị nhất là các bí quyết này có thể được hiểu và áp dụng bởi bất kỳ một người bình thường nào, hoạt động trong bất cứ lĩnh vực nào. Qua hơn 70 năm tồn tại, những đúc kết về thành công của Napoleon Hill đến nay vẫn không hề bị lỗi thời, ngược lại, thời gian chính là minh chứng sống động cho tính đúng đắn của những bí quyết mà ông chia sẻ.',
      author: 'Napoleon Hill',
      publisher: 'NXB Tổng Hợp TPHCM',
      publishingYear: '2020',
      price: 110000,
      discount: 0.1,
      images: 'other_dx001',
    ),
    ProductDemoData(
      title: 'Thiên Nga Đen (Tái Bản 2020)',
      type: 'bt006',
      description:
          'Trước khi khám phá ra thiên nga đen tồn tại trên đời (ở Úc), người ta vẫn tin rằng tất cả chim thiên nga trên đời đều có màu trắng. Phát hiện bất ngờ này đã thay đổi toàn bộ thế giới quan của nhân loại (về thiên nga).\nChúng ta không biết rất nhiều thứ nhưng lại hành động như thể mình có khả năng dự đoán được mọi điều. Và trong cuốn sách này, tác giả Nassim Nicholas Taleb đã đi sâu vào khai thác những sai lầm của tư tưởng cố hữu ấy. Theo ông, “thiên nga đen” là một biến cố tưởng chừng như không thể xảy ra với ba đặc điểm chính: không thể dự đoán, có tác động nặng nề và sau khi nó xảy ra, người ta lại dựng lên một lời giải thích để khiến nó trở nên ít ngẫu nhiên hơn, dễ dự đoán hơn so với bản chất thật của nó. Thành công đáng kinh ngạc của Facebook có thể được coi là một “thiên nga đen”, việc nước Anh rời khỏi Liên minh châu Âu cũng là một “thiên nga đen”. Thiên nga đen luôn ẩn hiện trong mọi mặt của cuộc sống với những tác động khó lường, theo cả hướng tiêu cực và tích cực.\nTinh tế, táo bạo nhưng không kém phần thú vị, Thiên Nga Đen chắc chắn là cuốn sách không thể bỏ qua cho những ai đam mê hiểu biết. Và cuốn sách này, bản thân nó cũng chính là một thiên nga đen…',
      author: 'Nassim Nicholas Taleb',
      publisher: 'NXB Thế Giới',
      publishingYear: '2020',
      price: 299000,
      discount: 0.15,
      images: 'other_dx002',
    ),
    ProductDemoData(
      title: '5 Phương Thức Ghi Nhận Nỗ Lực Của Nhân Viên',
      type: 'bt006',
      description:
          'Hầu hết các rắc rối trong mối quan hệ tại nơi công sở đều quy về một vấn đề: Nhân viên (cũng như đồng nghiệp) có cảm thấy họ được trân trọng với những đóng góp của mình hay không? Tuy vậy, mỗi người lại có ngôn ngữ biểu đạt sự trân trọng mong muốn khác nhau. Nếu chúng ta cố gắng bày tỏ theo những phương thức không có ý nghĩa với họ, họ sẽ chẳng hề cảm thấy được trân trọng.\nCuốn sách này sẽ cung cấp cho bạn các công cụ để cải thiện tinh thần nhân viên, xây dựng một môi trường làm việc tích cực hơn và tăng cường sự gắn kết trong nhân viên. Bằng cách nào? – Thông qua các phương pháp hiệu quả thể hiện sự ghi nhận và trân trọng đối với nhân viên, đồng nghiệp và lãnh đạo.',
      author: 'Gary Chapman, Paul White',
      publisher: 'NXB Công Thương',
      publishingYear: '2020',
      price: 119000,
      discount: 0.15,
      images: 'other_dx003',
    ),
    ProductDemoData(
      title: 'Nhân Loại - Một Lịch Sử Tràn Đầy Hi Vọng',
      type: 'bt006',
      description:
          'Trong cuốn sách Nhân loại, một lịch sử tràn đầy hi vọng,nhà sử học Rutger Bregman sẽ đưa độc giả vào cuộc hành trình phá bỏ những giả định của những nghiên cứu trước đây về bản chất con người vốn coi con người là ích kỉ và tư lợi, thay vào đó khám phá cách con người sử dụng bản chất rất đỗi tốt đẹp của mình để xây dựng một xã hội tốt đẹp hơn.',
      author: 'Rutger Bregman',
      publisher: 'NXB Dân Trí',
      publishingYear: '2021',
      price: 245000,
      discount: 0.15,
      images: 'other_dx004',
    ),
    ProductDemoData(
      title: 'Muôn Kiếp Nhân Sinh - Many Times, Many Lives',
      type: 'bt006',
      description:
          '“Muôn kiếp nhân sinh” là tác phẩm do Giáo sư John Vũ - Nguyên Phong viết từ năm 2017 và hoàn tất đầu năm 2020 ghi lại những câu chuyện, trải nghiệm tiền kiếp kỳ lạ từ nhiều kiếp sống của người bạn tâm giao lâu năm, ông Thomas – một nhà kinh doanh tài chính nổi tiếng ở New York. Những câu chuyện chưa từng tiết lộ này sẽ giúp mọi người trên thế giới chiêm nghiệm, khám phá các quy luật về luật Nhân quả và Luân hồi của vũ trụ giữa lúc trái đất đang gặp nhiều tai ương, biến động, khủng hoảng từng ngày.',
      author: 'Nguyên Phong',
      publisher: 'NXB Tổng Hợp TPHCM',
      publishingYear: '2020',
      price: 168000,
      discount: 0.3,
      images: 'other_dx005',
    ),
    ProductDemoData(
      title: 'Đại Việt Sử Ký Toàn Thư (Tái Bản 2022)',
      type: 'bt006',
      description:
          'Là bộ quốc sử danh tiếng, một di sản quý báu của dân tộc Việt Nam nghìn năm văn hiến. Đó là bộ sử cái, có giá trị nhiều mặt, gắn liền với tên tuổi các nhà sử học nổi tiếng như Lê Văn Hưu, Phan Phu Tiên, Ngô Sĩ Liên, Phạm Công Trứ, Lê Hy…\nViệc phát hiện bản in xưa nhất của bộ Đại Việt Sử Ký Toàn Thư, bản Nội các quan bản, năm Chính Hòa thứ 18, tức năm 1697 có một ý nghĩa đặc biệt. Bộ sách đã được ra mắt bạn đọc vào những năm 90 của thế kỷ trước và từng được tái bản trong những năm gần đây.',
      author: 'Đào Duy Anh',
      publisher: 'NXB Hồng Đức',
      publishingYear: '2022',
      price: 245000,
      discount: 0.15,
      images: 'other_dx006',
    ),
    ProductDemoData(
      title:
          'Lịch Sử Quân Sự - Bách Khoa Thư Các Loại Vũ Khí Định Hình Thế Giới',
      type: 'bt006',
      description:
          'Lịch Sử Quân Sự - Bách Khoa Thư Các Loại Vũ Khí Định Hình Thế Giới\nTập hợp đầy đủ các loại binh khí, máy móc, vật dụng quân sự, từ rìu tay đá lửa thời tiền sử tới vệ tinh do thám và máy bay không người lái ngày nay, Lịch sử Quân sự là bách khoa thư toàn diện về lịch sử không ngừng biến thiên của công nghệ chiến tranh.\nNhững minh họa chi tiết, sống động sẽ giúp độc giả như được tham quan tận mắt những đặc tính quan trọng của hơn 1750 loại vũ khí, giáp trụ, xe cộ và công sự. Tất cả được đặt trong các diễn biến chính được tường thuật rõ ràng của lịch sử chiến tranh, cùng bối cảnh chính trị - xã hội rộng lớn hơn. Kèm theo là những trận đánh nổi tiếng được phân tích trên phương diện vũ khí và chiến lược, nơi những tiến bộ công nghệ quân sự nổi bật trên tấm bản đồ quyền lực đầy biến động của các đế chế.\nLịch sử Quân sự, thành quả chung của nhóm chuyên gia đến từ Bảo tàng Vũ khí Hoàng gia Anh, Viện Smithsonian và các bảo tàng hàng đầu khác, sẽ cung cấp cho bạn đọc một bản tường thuật lý thú về những loại vũ khí và chiến thuật đã làm thay đổi bản chất chiến tranh.',
      author: 'DK',
      publisher: 'NXB Dân Trí',
      publishingYear: '2019',
      price: 550000,
      discount: 0.15,
      images: 'other_dx007',
    ),
    ProductDemoData(
      title: 'Từ Điển Tiếng Việt Hoàng Phê (Tái Bản)',
      type: 'bt006',
      description:
          'Trên thực tế, cuốn sách Từ điển Tiếng Việt (2021) Hoàng Phê của Viện Ngôn ngữ học đã là nguồn tra cứu, trích dẫn đáng tin cậy của hầu hết các bài viết, sách chuyên khảo, đặc biệt là các luận án tiến sĩ, luận văn thạc sĩ, khoá luận tốt nghiệp khi phân tích ý nghĩa của các đơn vị từ ngữ tiếng Việt, là cẩm nang tra cứu không thể thiếu của tất cả những người cầm bút, dù đó là nhà văn, nhà thơ, hay nhà báo, , kể cả các nhà giáo giảng dạy tiếng Việt. Đây là cuốn từ điển giải thích tiếng Việt có chất lượng và uy tín cao nhất so với bất cứ một cuốn từ điển giải thích tiếng Việt nào khác hiện có trên thị trường sách báo ở Việt Nam.',
      author: 'GS. Hoàng Phê',
      publisher: 'NXB Hồng Đức',
      publishingYear: '2021',
      price: 495000,
      discount: 0.15,
      images: 'other_dx008',
    ),
    ProductDemoData(
      title: 'Lưu Thông Máu Tốt Hóa Giải Bách Bệnh',
      type: 'bt005',
      description:
          'Ngay từ tiêu đề sách, tác giả Akiyoshi Horie khẳng định việc lưu thông máu có thể hoá giải bách bệnh. Điều đó có thật không? Liệu rằng dòng chảy âm thầm của máu có thật sự tạo ra tác động ở cả mặt thể chất lẫn tinh thần?',
      author: 'Akiyoshi Horie',
      publisher: 'NXB Công Thương',
      publishingYear: '2021',
      price: 99000,
      discount: 0.25,
      images: 'science_dx001',
    ),
    ProductDemoData(
      title: 'Cơ Thể Tự Chữa Lành: Phục Hồi Tuyến Giáp',
      type: 'bt005',
      description:
          '“Theo ý kiến chuyên môn của tôi, có lẽ, cứ 10 người Mỹ thì có 7 người mắc bệnh tuyến giáp. Bằng cách đọc cuốn sách quý giá này, bạn sẽ có thêm nhiều hiểu biết sâu sắc về những chẩn đoán của mình và thu được thông tin cần thiết để bệnh tật không trầm trọng hơn. Sau khi đọc cuốn Cơ thể tự chữa lành – Phục hồi tuyến giáp của Anthony, tôi rõ ràng đã có thêm nhiều thông tin và giải pháp để áp dụng cho những ca bệnh phức tạp. Thật vậy, Anthony đã vô cùng chính xác khi viết rằng, không phải mọi bệnh nhân đều phản ứng với  nội tiết tố tuyến giáp theo cách chúng ta dự đoán hay hy vọng.”\n— Bác sĩ Prudence Hall, nhà sáng lập và giám đốc y khoa tại The Hall Center',
      author: 'Anthony William',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2021',
      price: 180000,
      discount: 0.25,
      images: 'science_dx002',
    ),
    ProductDemoData(
      title: 'Cơ Thể Tự Chữa Lành: Giải Cứu Gan',
      type: 'bt005',
      description:
          'Cơ thể tự chữa lành - Giải cứu gan là cuốn sách tiếp theo trong bộ sách Cơ thể tự chữa lành của tác giả có sách bán chạy số 1 theo New York Times bình chọn: Anthony William. Trong tác phẩm mới này, ông sẽ hé mở bức màn bí mật về đặc điểm, cơ chế hoạt động và những điều bí ẩn xoay quanh lá gan của con người.',
      author: 'Anthony William',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2021',
      price: 250000,
      discount: 0.25,
      images: 'science_dx003',
    ),
    ProductDemoData(
      title: 'Cơ Thể Tự Chữa Lành',
      type: 'bt005',
      description:
          'Cơ thể tự chữa lành tiết lộ nguyên nhân gốc rễ của nhiều căn bệnh mà các cộng đồng y tế còn nhầm lẫn hoặc chưa hiểu hết. Qua cuốn sách, tác giả đưa ra những phương pháp hoàn toàn tự nhiên để chữa lành rất nhiều căn bệnh đang hành hạ vô số người trong chúng ta, như bệnh Lyme, đau xơ cơ, mệt mỏi tuyến thượng thận, mệt mỏi mạn tính, mất cân bằng nội tiết tố, v.v... Hơn thế nữa, tác giả còn cung cấp nhiều giải pháp hồi phục tinh thần và linh hồn mỗi người, sau một thời gian dài phải chịu đựng cơn bệnh quái ác giằng xé. ',
      author: 'Anthony William',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2020',
      price: 160000,
      discount: 0.25,
      images: 'science_dx004',
    ),
    ProductDemoData(
      title: 'Cơ Thể Tự Chữa Lành: Thực Phẩm Thay Đổi Cuộc Sống',
      type: 'bt005',
      description:
          'Cơ thể tự chữa lành: Thực phẩm thay đổi cuộc sống - Thần dược đến từ trái cây và rau củ giúp chúng ta tăng nhận thức và có cái nhìn mới về những loại trái cây và rau củ -  những tinh túy mà thiên nhiên đã ban tặng cho chúng ta. Đối với mỗi loại thực phẩm được liệt kê trong cuốn sách, tác giả sẽ kèm theo một danh sách các căn bệnh và triệu chứng mà thứ trái cây hoặc rau củ đó sẽ giúp giảm nhẹ tình trạng bệnh, đồng thời chỉ ra rất nhiều lợi ích của chúng trong việc hỗ trợ về mặt tinh thần và cảm xúc. Ngoài ra, còn có những công thức các món ăn ngon lành và dễ làm xuyên suốt cuốn sách.',
      author: 'Anthony William',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2020',
      price: 185000,
      discount: 0.25,
      images: 'science_dx005',
    ),
    ProductDemoData(
      title: 'Cơ Thể Tự Chữa Lành - Thanh Lọc Để Phục Hồi',
      type: 'bt005',
      description:
          'Nếu bạn nghĩ rằng mình không cần phải thanh lọc - nếu bạn chắc chắn rằng bạn không thể chứa bất kỳ độc tố nào trong cơ thể - hãy nghĩ lại. Trong thế giới ngày nay, có những chất độc và mầm bệnh đe dọa sức khỏe của chúng ta bắt đầu từ trước khi chúng ta được sinh ra, và chúng tiếp tục kìm hãm chúng ta khi chúng ta gặp phải chúng trong cuộc sống hàng ngày.Thanh lọc là một công cụ quan trọng để chống lại những gánh nặng này - miễn là bạn thực hiện đúng cách.',
      author: 'Anthony William',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2022',
      price: 295000,
      discount: 0.25,
      images: 'science_dx006',
    ),
    ProductDemoData(
      title: 'Cơ Thể Tự Chữa Lành: Nước Ép Cần Tây',
      type: 'bt005',
      description:
          'Cuốn sách tập trung bàn về bản chất, công dụng của nước ép cần tây trong việc điều trị bệnh và phục hồi sức khỏe. Đây là phương pháp đã được vô số người áp dụng và mang lại những hiệu quả vô cùng sâu sắc.',
      author: 'Anthony William',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2020',
      price: 148000,
      discount: 0.2,
      images: 'science_dx007',
    ),
    ProductDemoData(
      title: 'Giáo Trình Kỹ Thuật Lập Trình C Căn Bản & Nâng Cao',
      type: 'bt005',
      description:
          'Cùng với sự phát triển như vũ bão của khoa học kỹ thuật nói chung, ngành Công nghệ Thông tin nói riêng đã và đang thâm nhập vào thực tiễn của mọi lĩnh vực trong cuộc sống và hoạt động của con người, trong đó công nghệ lập trình cũng không ngừng phát triển và ngày một ứng dụng rộng rãi hơn.Trong các ngôn ngữ lập trình, ngôn ngữ lập trình C từ lâu đã trở thành ngôn ngữ phổ biến vì tính đa dụng và linh hoạt của nó. Từ một nhà lập trình có tên tuổi cho đến một sinh viên công nghệ thông tin hoặc người yêu thích công nghệ thông tin đều không thể phủ nhận khả năng giải quyết vì xử lý nhanh một bài toán, từ đơn giản đến phức tạp, trên nhiều lĩnh vực khác nhau của ngôn ngữ C. Để đáp ứng nhu cầu mong muốn của nhiều bạn đọc, Nhà xuất bản Thông tin và Truyền thông trân trọng giới thiệu cuốn sách “Giáo trình Kỹ thuật lập trình C: Cơ sở và nâng cao” của PGS. TS Phạm Văn Ất, một tên tuổi quen thuộc với bạn đọc yêu thích ngôn ngữ C',
      author: 'PGS. TS Phạm Văn Ất, TS. Đỗ Văn Tuấn',
      publisher: 'NXB Thông Tin Và Truyền Thông',
      publishingYear: '2022',
      price: 135000,
      discount: 0.15,
      images: 'science_dx008',
    ),
    ProductDemoData(
      title:
          'Cẩm Nang Sử Dụng Máy Tính Khoa Học Casio Fx-880BTG Thế Hệ Mới Lớp 6-12',
      type: 'bt005',
      description:
          'Bắt đầu từ năm 2021, chương trình Giáo dục phổ thông 2018 áp dụng cho lớp 6 và vào năm 2022 áp dụng cho lớp 10. Sự đổi mới này ban đầu gây ra rất nhiều lúng túng cho các nhà quản lý giáp dục, phụ huynh và toàn xã hội. Các hoạt động trải nhiệm thực tế, các chuyên đề trong chương trình là những nét rất mới và không kế thừa được các kinh nghiejm có sẵn vì đây là lần đầu tiên thực hiện chương trình này.\nQuyển sách Cẩm nang sử dụng máy tính khoa học Casio Fx-880BTG thế hệ mới Lớp 6-12 là tâm huyest của Ban lãnh đạo Công ty Bitex cùng Tiến sĩ Nguyễn Thái Sơn - Trưởng bộ phận nghiên cứu và Ứng dụng - Phòng phát triển Giáo dục - BITEX, nguyên trưởng khoa Toán Tin học - Đại học Sư Phạm thành phố Hồ Chí Minh ( 2000-2009), Nguyên Giám đốc - tổng biên tập nhà xuất bản ĐHSP Thành phố Hồ Chí Minh (2009-2011).',
      author: 'TTNC ỨNG DỤNG GD',
      publisher: 'Đại Học Sư Phạm Tp.HCM',
      publishingYear: '2022',
      price: 50000,
      discount: 0.15,
      images: 'science_dx009',
    ),
    ProductDemoData(
      title: '100 Bí Ẩn Đáng Kinh Ngạc Về Vũ Trụ',
      type: 'bt005',
      description:
          'Bạn nhỏ có biết rằng Trái Đất đã rất rộng lớn rồi, nhưng hơn một triệu Trái Đất... có thể nhét vừa vào Mặt Trời! \n- Có một đám mây ở không gian ngoài thiên thể... có vị giống dâu rừng?\n- Mặt trời không phải màu vàng đâu nhé, thật ra nó có màu trắng sáng đấy.\nHãy cùng khám phá những điều thú vị về vũ trụ qua các tiết lộ “đáng kinh ngạc” nhé!',
      author: 'Alex Frith, Alice James, Jerome Martin',
      publisher: 'NXB Thế Giới',
      publishingYear: '2018',
      price: 100000,
      discount: 0.25,
      images: 'science_dx010',
    ),
    ProductDemoData(
      title: 'Khoa Học Khám Phá - Lược Sử Thời Gian (Tái Bản 2022)',
      type: 'bt005',
      description:
          'Tò mò là một trong những phẩm chất bẩm sinh vô cùng quan trọng của chúng ta, và những vấn đề như Bản chất của vũ trụ là gì? Vũ trụ từ đâu ra? Chúng ta đến từ đâu và đóng vai trò gì trong vũ trụ? Có giới hạn cho sự nhận thức của con người không?... là những câu hỏi mà biết bao nhiêu thế hệ con người đã đặt ra dưới dạng này hoặc dạng khác từ khi bắt đầu biết nhận thức và suy ngẫm về thế giới này. Tất cả những vấn đề được nên ra trong tác phẩm Lược sử thời gian như Vũ trụ giãn nở, Lỗ đen, Nguồn gốc và số phận của vũ trụ, Mũi tên thời gian… đều là mong muốn của tác giả để phần nào trả lời được những câu hỏi đó, và hướng tới việc giải thích các giai đoạn lịch sử của toàn bộ vũ trụ.\nBằng ngôn ngữ sáng sủa, lập luận chặt chẽ rất thuyết phục, và sự dí dỏm rất riêng, tác giả Stephen Hawking đặt ra cho mình nhiệm vụ diễn tả những điều phức tạp nhất trong vật lý học một cách dễ hiểu đối với mọi người, không dùng bất kỳ công thức toán học nào, trừ phương trình nổi tiếng của Einstein: E = mc2',
      author: 'Stephen Hawking',
      publisher: 'NXB Trẻ',
      publishingYear: '2022',
      price: 115000,
      discount: 0.15,
      images: 'science_dx011',
    ),
    ProductDemoData(
      title: 'Kỹ Thuật Sửa Chữa Ô Tô Cơ Bản (Tái Bản 2019)',
      type: 'bt005',
      description:
          'Quyển sách cung cấp cho những người bắt đầu làm quen với ngành công nghiệp sửa chữa, bảo dưỡng ô tô. Cuốn sách được trình bày theo phương thức đơn giản, rõ ràng, dễ hiểu, dễ thực hành giúp người học nhanh chóng nắm vững được những khái niệm và kỹ năng thao tác cơ bản cho công việc sửa chữa và bảo dưỡng ô tô.\nCuốn sách cũng kết hợp với số lượng lớn hình ảnh minh họa tạo nên trực quan sinh động, phù hợp với cả người mới vào nghề và người thợ lâu năm.\nĐược biên soạn và tư vấn bởi nhiều chuyên gia và kỹ thuật viên lành nghề, cuốn sách sẽ trang bị cho bạn nhiều kiến thức hay và bổ ích.',
      author: 'Đức Huy',
      publisher: 'NXB Bách Khoa Hà Nội',
      publishingYear: '2018',
      price: 98000,
      discount: 0.15,
      images: 'science_dx012',
    ),
    ProductDemoData(
      title: 'Sao Chúng Ta Lại Ngủ - Why We SLeep',
      type: 'bt005',
      description:
          'Sao Chúng Ta Lại Ngủ - Why We SLeep\nLà cuốn sách về giấc ngủ đầu tiên được viết bởi chính một chuyên gia khoa học hàng đầu, giám đốc Trung tâm về Khoa học Giấc ngủ Con người của trường Đại học California, Berkeley, Sao chúng ta lại ngủ trở thành một cuộc khám phá mang tính đột phá về giấc ngủ, giải thích việc chúng ta có thể khai thác được sức mạnh biến đổi của giấc ngủ nhằm làm thay đổi cuộc sống của chúng ta trở nên tốt đẹp hơn như thế nào.',
      author: 'Matthew Walker',
      publisher: 'NXB Lao Động',
      publishingYear: '2019',
      price: 249000,
      discount: 0.25,
      images: 'science_dx013',
    ),
    ProductDemoData(
      title:
          'Truyện Kể Bốn Mùa - Cơn Giận Chóng Qua - Giúp Con Kiểm Soát Cảm Xúc',
      type: 'bt004',
      description:
          'Các bạn thân mến!\nThói quen đọc sách từ sớm không chỉ bồi dưỡng tâm hồn mỗi người mà còn giúp các bạn nhỏ hình thành những thói quen tích cực và phát triển kỹ năng học tập sau này\nTruyện kể bốn mùa là bộ sách mang lại cho độc giả nhí những trải nghiệm đọc sách thú vị. Làm quen với gấu Nono và những người bạn ở khu rừng vui vẻ, các bạn nhỏ sẽ được khám phá cuộc sống xung quanh mình và rút ra những bài học ý nghĩa, để rồi từ đó biết cách ứng biến khi gặp tình huống khó khăn, học cách kế bạn và sống hòa đồng, kiếm soát cảm xúc và vun đắp những tình cảm tốt đẹp..\nChúc các bạn có những khoảng thời gian đọc sách vui vẻ và phát hiện ra những món quà bất ngờ đằng sau mỗi truyện kể hấp dẫn này nhé!',
      author: 'Marie Tibi, Fabien Öckto Lambert',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2021',
      price: 39000,
      discount: 0.27,
      images: 'child_dx001',
    ),
    ProductDemoData(
      title:
          'Những Lời Yêu Thương Của Con Trẻ Dành Tặng Các Mẹ - Vì Sao Tớ Yêu Mẹ (Tái Bản 2019)',
      type: 'bt004',
      description:
          'Seri sách tranh “Vì sao tớ yêu...” được đông đảo bạn đọc nhỏ tuổi yêu thích và say mê đọc mỗi tối. Bằng tranh vẽ biểu cảm, thơ mộng về thế giới tự nhiên cùng lời văn êm ái, ngọt ngào như thơ, bộ sách “Vì sao tớ yêu...” là những lời yêu thương của con trẻ trên khắp thế giới dành tặng cho ông bà, cha mẹ mình...',
      author: 'Daniel Howarth',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2019',
      price: 25000,
      discount: 0.15,
      images: 'child_dx002',
    ),
    ProductDemoData(
      title: 'Mẹ Hỏi Bé Trả Lời 4-5 Tuổi (Tái Bản 2019)',
      type: 'bt004',
      description:
          'Bộ sách nhỏ xinh “Mẹ hỏi bé trả lời” tập hợp những trò chơi phong phú, câu đố thông minh giúp bé và cha mẹ có thể “học mà chơi, chơi mà học” qua các chủ đề: cách ứng xử, câu hỏi về tự nhiên, không gian, phân biệt hình khối, ngôn ngữ, toán học...\nSách phân chia theo từng lứa tuổi với nội dung phong phú, những câu hỏi đáp hàm súc trí tuệ, hình ảnh dễ thương cùng nhiều phương pháp rèn luyện, hoàn toàn có thể khơi dậy trí thông minh và khả năng tiềm ẩn của bé.',
      author: 'Yosbook, Xiao Li',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2019',
      price: 30000,
      discount: 0.15,
      images: 'child_dx003',
    ),
    ProductDemoData(
      title: 'Ehon - Moi Moi',
      type: 'bt004',
      description:
          'Năm 2017, "Moi Moi" ra đời sau 2 năm nghiên cứu bởi 5000 người, bao gồm Giáo sư Hiraki Kazuo cùng cộng sự tại Phòng Nghiên cứu trẻ sơ sinh thuộc Đại học Tokyo, và rất nhiều những ông bố, bà mẹ và em bé khác trên khắp Nhật Bản.\nNgay trong 7 tháng đầu tiên kể từ khi phát hành, "Moi Moi" bán ra hơn 100.000 bản. Theo thống kê, cứ 7 em bé Nhật Bản thì có 1 em bé đọc "Moi Moi". Cuốn Ehon này cũng liên tục đứng trong top những cuốn sách bán chạy nhất: #1 năm 2018 trên A, #1 “Ehon của năm 2018” của Rakuten Books,\nĐây thực sự là một cú hit lớn trong ngành Ehon Nhật Bản. Vậy cuốn ehon có điều gì mà có thể khiến các em bé ngừng khóc? - Đầu tiên, đó là hình ảnh minh họa. Em bé thường chú ý tới những hình vẽ có màu sắc rực rỡ, tươi sáng và hình dạng tương tự như khuôn mặt hay đôi mắt của con người. “Nhân vật chính” của Moi Moi đáp ứng được những điều kiện đó, và là hình minh họa được chính các em bé lựa chọn thông qua những cuộc thực nghiệm.',
      author: 'Hiraki Kazuo',
      publisher: 'NXB Lao Động Xã Hội',
      publishingYear: '2019',
      price: 39000,
      discount: 0.15,
      images: 'child_dx004',
    ),
    ProductDemoData(
      title: 'Gieo Mầm Tính Cách - Tự Tin (Tái Bản 2019)',
      type: 'bt004',
      description:
          'Tính cách của trẻ được hình thành từ rất sớm, thông qua sự giáo dục trong gia đình, qua những việc làm, lời nói, cách ứng xử của những người xung quanh. Nhưng ở độ tuổi nhỏ, không thể ép trẻ phát triển tính cách theo ý muốn của cha mẹ bằng lời dạy dỗ suông, bằng những bài học đạo đức khô khan, mà những tấm gương đẹp về tính cách đó phải được gieo vào trẻ từ từ bằng những câu chuyện sinh động, hấp dẫn.\nBộ sách Gieo mầm tính cách (12 tập) là tập hợp những câu chuyện như vậy. Mỗi tập là một hạt giống tính cách gieo vào trẻ những bài học Tử tế, Tha thứ, Kiên trì, Thật thà, Quan tâm, Yêu thương, Mạnh mẽ, Tự tin, Ước mơ, Lịch sự, Hiếu thảo, Công bằng bằng những câu chuyện cảm động, đầy ý nghĩa đáng để suy ngẫm.\nMỗi câu chuyện được trình bày kèm với một câu tục ngữ, thành ngữ, ca dao, danh ngôn nhằm nhấn mạnh thêm thông điệp mà người tuyển chọn muốn gửi gắm. Không chỉ vậy, những bài học sau mỗi câu chuyện được xây dựng gần gũi, nhiều gợi mở cho người đọc triển khai thêm nhiều suy nghĩ sau khi đọc truyện, so sánh, áp dụng thực tế và tự xét bản thân.',
      author: 'Hà Yên',
      publisher: 'NXB Trẻ',
      publishingYear: '2019',
      price: 32000,
      discount: 0.15,
      images: 'child_dx005',
    ),
    ProductDemoData(
      title:
          'Bách Khoa Tri Thức Về Khám Phá Thế Giới Cho Trẻ Em - Thiên Văn Học',
      type: 'bt004',
      description:
          'Nội dung của bộ sách Bách Khoa Tri Thức Về Khám Phá Thế Giới Cho Trẻ Em đề cập đến rất nhiều những vấn đề mà trẻ muốn biết, từ vũ trụ, trái đất đến giới động vật, thực vật, từ khoa học kỹ thuật đến xã hội cuộc sống. Sách được minh họa bằng những bức tranh sinh động, ngôn ngữ của  đơn giản, dễ hiểu. Mỗi một chủ đề giúp trẻ nhận thức thế giới, tăng cường tri thức, nâng cao khả năng sáng tạo và trí tưởng tượng.\nNgoài ra, sách còn giới thiệu những trang web chứa đựng nhiều thông tin, trò chơi và hoạt động thú vị, cập nhật thêm các tin tức mới nhất về các chủ đề.',
      author: 'Rachel Firth',
      publisher: 'NXB Thế Giới',
      publishingYear: '2018',
      price: 45000,
      discount: 0.27,
      images: 'child_dx006',
    ),
    ProductDemoData(
      title: 'Mẹ Hỏi Bé Trả Lời 1-2 Tuổi (Tái Bản 2019)',
      type: 'bt004',
      description:
          'Bộ sách nhỏ xinh “Mẹ hỏi bé trả lời” tập hợp những trò chơi phong phú, câu đố thông minh giúp bé và cha mẹ có thể “học mà chơi, chơi mà học” qua các chủ đề: cách ứng xử, câu hỏi về tự nhiên, không gian, phân biệt hình khối, ngôn ngữ, toán học...\nSách phân chia theo từng lứa tuổi với nội dung phong phú, những câu hỏi đáp hàm súc trí tuệ, hình ảnh dễ thương cùng nhiều phương pháp rèn luyện, hoàn toàn có thể khơi dậy trí thông minh và khả năng tiềm ẩn của bé.',
      author: 'Yosbook, Xiao Li',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2019',
      price: 30000,
      discount: 0.15,
      images: 'child_dx007',
    ),
    ProductDemoData(
      title: 'Bé Khoẻ Mỗi Ngày: Nếu Không Rửa Tay Thì Sao?',
      type: 'bt004',
      description:
          'Muốn phòng chống vi khuẩn, việc trước tiên ta cần làm chính là rửa tay sạch sẽ. Nhưng điều gì sẽ xảy ra khi bé Minh mải chơi không chịu rửa tay? Chúng mình cùng xem nhé!',
      author: 'Hoàng Hoành, Kẹo Bông, Lan Phương',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2021',
      price: 30000,
      discount: 0.15,
      images: 'child_dx008',
    ),
    ProductDemoData(
      title: 'Bé An Toàn Mỗi Ngày: Nếu Chẳng May Đi Lạc Thì Sao?',
      type: 'bt004',
      description:
          'Hôm nay Minh và mẹ bắt tàu điện ngầm đi tham quan bảo tàng. Lúc lên tàu, do lơ đãng, không theo kịp mẹ nên Minh bị “rớt lại” bên ngoài khoang tàu. May sao, Minh đã bình tĩnh vận dụng những kiến thức đã học và tìm được mẹ. Minh đã làm thế nào nhỉ? Chúng mình cùng tìm hiểu nhé!',
      author: 'Hoàng Hoành, Kẹo Bông',
      publisher: 'NXB Kim Đồng',
      publishingYear: '2021',
      price: 35000,
      discount: 0.15,
      images: 'child_dx009',
    ),
    ProductDemoData(
      title: '200 Miếng Bóc Dán Thông Minh - Bé Học Toán',
      type: 'bt004',
      description:
          'Đây là cuốn sách được tuyển chọn và những trò chơi dán hình, giúp cho đôi tay của các em thêm linh hoạt, khéo léo, nhận biết được các hình để bóc và dán cho đúng chỗ...',
      author: 'Ngọc Linh',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2018',
      price: 55000,
      discount: 0.25,
      images: 'child_dx010',
    ),
    ProductDemoData(
      title:
          'Truyện Kể Cho Bé Trước Giờ Đi Ngủ - Ngày Xửa Ngày Xưa: Cô Bé Quàng Khăn Đỏ',
      type: 'bt004',
      description:
          'Truyện kể cho bé trước giờ đi ngủ - Ngày xửa ngày xưa mang đến những câu chuyện cổ tích quen thuộc đã trở thành kinh điển, tất cả được kể lại một cách ngắn gọn, súc tích cùng với hình ảnh minh họa sống động, nhiều màu sắc. Ở mỗi tập truyện, trẻ không chỉ được thả hồn vào thế giới cổ tích thần tiên, mà còn rút ra được cho mình nhiều bài học hay, đầy tính nhân văn.\nMỗi tập truyện còn có phần Câu hỏi gợi ý, Trò chơi thử thách, Bài học ý nghĩa kèm theo, giúp bố mẹ có thể tương tác nhiều hơn với trẻ trong khi kể chuyện. Qua những hoạt động gắn kết cùng bố mẹ, trẻ sẽ được vun đắp thêm tình cảm gia đình và lớn khôn lên mỗi ngày.',
      author: 'Nhiều Tác Giả',
      publisher: 'NXB Thanh Niên',
      publishingYear: '2022',
      price: 16000,
      discount: 0.27,
      images: 'child_dx011',
    ),
  ];
}
