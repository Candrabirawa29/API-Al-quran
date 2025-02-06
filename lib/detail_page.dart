import 'package:flutter/material.dart';
import 'http_service.dart';
import 'post_model.dart';

class DetailPage extends StatelessWidget {
  final HttpService httpService = HttpService();
  final int nomor;

  DetailPage({required this.nomor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Surah"),
      ),
      body: FutureBuilder(
        future: httpService.getDetail(nomor),
        builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
          if (snapshot.hasData) {
            Post detail = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${detail.nomor}. ${detail.nama_latin}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    detail.nama,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Arti: ${detail.arti}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Jumlah ayat: ${detail.jumlah_ayat}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tempat turun: ${detail.tempat_turun}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (detail.ayat != null)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: detail.ayat!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Ayat ayat = detail.ayat![index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ayat ${ayat.nomor}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  ayat.ar,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                // SizedBox(height: 10),
                                // Text(
                                //   ayat.tr,
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     color: Colors.grey[700],
                                //   ),
                                // ),
                                SizedBox(height: 10),
                                Text(
                                  ayat.idn,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}