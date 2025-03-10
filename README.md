# ristekflix

## Lesson Learned

Pada proyek ini, hal utama yang saya pelajari adalah API call pada Flutter. Ternyata, 
proses pengambilan data dari server tidak sesederhana yang saya bayangkan. Saya harus 
memahami bagaimana cara mengirim permintaan HTTP, mengelola respons yang diterima, serta 
menangani berbagai skenario seperti error handling dan caching untuk meningkatkan efisiensi 
aplikasi. Selain itu, saya juga belajar tentang cara mengelola state agar data yang 
ditampilkan selalu up-to-date tanpa membebani performa aplikasi. Dengan pemahaman ini, 
saya semakin yakin bahwa membangun aplikasi mobile tidak hanya tentang tampilan yang 
menarik, tetapi juga bagaimana data dikelola dengan optimal untuk memberikan pengalaman 
terbaik bagi pengguna.

Saat mengimplementasi modul SearchScreen, saya mencoba untuk melakukan API call yang berbasis 
interval waktu agar pencarian menjadi lebih responsif. Awalnya, saya langsung memanggil 
API setiap kali pengguna mengetikkan huruf baru dalam kolom pencarian. Namun, saya segera 
menyadari bahwa pendekatan ini menyebabkan banyak permintaan yang tidak perlu, 
memperlambat aplikasi, dan meningkatkan penggunaan kuota API secara signifikan.

Selanjutnya, saya juga menyadari bahwa Clean Architecture sangat berpengaruh terhadap 
skalabilitas dan kemudahan pemeliharaan aplikasi. Code logic yang langsung di dalam widgets 
akan membuat kode sulit dibaca dan diperbaiki seiring bertambahnya fitur. Seiring waktu, 
saya mulai memahami pentingnya menerapkan Clean Architecture untuk memisahkan business 
logic, data layer, dan presentation layer. Adapun untuk struktur projek, saya memisahkannya 
menjadi authentication, helpers, repository, screens, services, dan widgets.

Last but not least, saya juga bereksperimen dengan Firebase untuk autentikasi serta database. Saya mempelajari bagaimana mengimplementasikan sistem login dan registrasi yang aman menggunakan Firebase Authentication, termasuk penggunaan autentikasi berbasis email.

Implementasi ini mengajarkan saya bahwa dalam pengembangan aplikasi mobile, performa dan 
efisiensi harus selalu dipertimbangkan, terutama saat berinteraksi dengan API. Tidak hanya 
sekadar memastikan bahwa fitur bekerja, tetapi juga bagaimana fitur tersebut dapat berjalan 
dengan optimal untuk memberikan pengalaman terbaik bagi pengguna.

## Demonstration

Demonstrasi register

![](assets/images/register.gif)

Demonstrasi laman utama

![](assets/images/general.gif)

Demonstrasi laman search

![](assets/images/search.gif)

Demonstrasi laman profil, notice perubahan feedsnya yang menyesuaikan

![](assets/images/profile.gif)

Tampilan laman about

![](assets/images/about.png)

## Third-Party Libraries

Proyek ini menggunakan beberapa third-party libraries untuk mendukung berbagai fitur:

- [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) - Ikon bergaya iOS untuk Flutter.
- [`carousel_slider`](https://pub.dev/packages/carousel_slider) - Widget carousel yang dapat dikustomisasi.
- [`http`](https://pub.dev/packages/http) - Library untuk melakukan HTTP requests.
- [`font_awesome_flutter`](https://pub.dev/packages/font_awesome_flutter) - Font Awesome Icons untuk Flutter.

Selain itu, proyek ini juga menggunakan Firebase SDK untuk berbagai layanan backend:

- [`firebase_core`](https://pub.dev/packages/firebase_core) - Library inti Firebase untuk menginisialisasi Firebase dalam aplikasi.
- [`firebase_auth`](https://pub.dev/packages/firebase_auth) - Autentikasi pengguna menggunakan Firebase Authentication.
- [`cloud_firestore`](https://pub.dev/packages/cloud_firestore) - Cloud Firestore sebagai database realtime.
- [`firebase_storage`](https://pub.dev/packages/firebase_storage) - Penyimpanan file menggunakan Firebase Storage.

