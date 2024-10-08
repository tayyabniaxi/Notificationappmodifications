import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_wallpaper_app/theme/app_theme.dart';
import '../widgets/full_screen_image_page.dart';
import 'package:provider/provider.dart';
import '../viewmodels/theme_view_model.dart';

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedCategory = 'Popular';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Map<String, List<String>> cachedImages = {};

  Future<List<String>> _fetchCategoryImageUrls(String category) async {

    if (cachedImages.containsKey(category)) {
      return cachedImages[category]!;
    }

    final doc = await firestore.collection('categories').doc(category).get();
    List<String> imageUrls = [];
    if (doc.exists) {
      imageUrls = List<String>.from(doc['images'] ?? []);
      cachedImages[category] = imageUrls;
    }
    return imageUrls;
  }

  Future<bool> _isImageFavorite(String url) async {
    final favRef = firestore.collection('userFavorites').where('url', isEqualTo: url);
    final snapshot = await favRef.get();
    return snapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final themeViewModel = Provider.of<ThemeViewModel>(context);

    Color selectedColor = themeViewModel.isDarkMode ? AppColors.purpleColor : AppColors.purpleColor;
    Color defaultColor = themeViewModel.isDarkMode ? AppColors.lightPurpleColor : AppColors.lightPurpleColor;
    Color wallpaperColor = themeViewModel.isDarkMode ? Colors.white : Colors.black;
    Color wallpaperTextColor = themeViewModel.isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Wallpaper', 'Popular', 'Nature', 'Random'].map((category) {
                final isSelected = category == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    if (category != 'Wallpaper') {
                      setState(() {
                        selectedCategory = category;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: category == 'Wallpaper' ? wallpaperColor : (isSelected ? selectedColor : defaultColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          category,
                          style: TextStyle(color: isSelected || category == 'Wallpaper' ? wallpaperTextColor : Colors.black),
                        ),
                        if (category == 'Wallpaper') ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: _fetchCategoryImageUrls(selectedCategory),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading images: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No images available'));
                } else {
                  final imageUrls = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                        childAspectRatio: 0.5,
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          bool isFavorite = await _isImageFavorite(imageUrls[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImagePage(
                                imageUrl: imageUrls[index],
                                isFavorite: isFavorite, onFavoriteToggle: () {},
                              ),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: imageUrls[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      );
                    },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}