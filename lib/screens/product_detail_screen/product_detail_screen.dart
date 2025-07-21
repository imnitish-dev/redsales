import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/delivery_selector_widget.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/originInfoWidget.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/popular_items_widget.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/product_image_carousel.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/review_widget.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/size_selector_widget.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/specifications_widget.dart';
import 'package:twocliq/screens/product_detail_screen/widgets/you_might_like_widget.dart';

import '../../helper/animatedPage.dart';
import '../../helper/constants.dart';
import '../../models/product_detail_model.dart';
import '../../provider/detailed_product_screen_provider.dart';
import '../../provider/home_provider.dart';
import '../widgets/shimmer_widget.dart';
import 'all_reviews_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  String? selectedSizeID;
  String? selectedDeliveryOption;

  void callData(){
    Future.microtask(() {
      Provider.of<DetailedProductScreenProvider>(context, listen: false).loadProductDetail(productId: widget.productId);
    });
  }



  final options = [
    DeliveryOption(title: "Standard Delivery", time: "5–7 days", price: "₹699"),
    DeliveryOption(title: "Express Delivery", time: "2–3 days", price: "₹699"),
  ];

  final reviews = [
    ReviewModel(
      profileImage: "https://randomuser.me/api/portraits/women/1.jpg",
      name: "Veronika Singhania",
      rating: 5,
      review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
    ),
    ReviewModel(
      profileImage: "https://randomuser.me/api/portraits/women/2.jpg",
      name: "Veronika Singhania",
      rating: 4,
      review: "Sed diam nonumy eirmod tempor invidunt ut labore et dolore...",
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    callData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
        Consumer<DetailedProductScreenProvider>(
          builder: (context, provider, _) {
            switch (provider.status) {
              case ApiLoadingState.loading:
                return buildLoadingShimmer();

              case ApiLoadingState.error:
                return Center(
                  child: Text(
                    provider.errorMessage ?? "Failed to load",
                    style: const TextStyle(color: Colors.red),
                  ),
                );

              case ApiLoadingState.success:
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 9.h,left: 10.w),
                              child: Padding(
                                padding:  EdgeInsets.all(8.0.r),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, icon: Icon(FeatherIcons.chevronLeft,size: 30.r,color: Colors.black.withOpacity(0.4),)),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width/2,
                                          child: Text(

                                            provider.currentProductDetail?.productDetails?.productTitle??'',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            //"Granactive Retinoid 5%",
                                            style: customTextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black.withOpacity(0.6),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outlined,color: Colors.redAccent))
                                  ],
                                ),
                              ),
                            ),
                             ImagesCarousel(
                              images: provider.currentProductDetail?.images??[]
                              /*[
                                "https://imgmediagumlet.lbb.in/media/2024/09/66e023d74093fc4320cb024a_1725965271288.jpg",
                              ],*/
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 25.w,top: 15.h),
                              child: Row(
                                children: [
                                  priceAndDescWidget(productDetails: provider.currentProductDetail?.priceDetails),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h, bottom: 20.h),
                              child: DottedLine(
                                dashColor: Colors.grey.withOpacity(0.25),
                                dashLength: 5,
                                dashGapLength: 3,
                                lineThickness: 2,
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: 25.w),
                              child: SizeSelector(
                                prices: provider.currentProductDetail!.priceDetails?.customPrice,
                                onSelected: (size) {
                                  logInfo("Selected size: $size");
                                  selectedSizeID = size;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h, bottom: 20.h),
                              child: DottedLine(
                                dashColor: Colors.grey.withOpacity(0.25),
                                dashLength: 5,
                                dashGapLength: 3,
                                lineThickness: 2,
                              ),
                            ),

                            SpecificationsWidget(productSpecification: provider.currentProductDetail!.specifications),

                          /*  Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h, bottom: 20.h),
                              child: DottedLine(
                                dashColor: Colors.grey.withOpacity(0.25),
                                dashLength: 5,
                                dashGapLength: 3,
                                lineThickness: 2,
                              ),
                            ),
*/
                           /* Padding(
                              padding:  EdgeInsets.only(left: 25.w),
                              child: const OriginInfo(value: "EU"),
                            ),*/




                            /*Padding(
                              padding:  EdgeInsets.only(left: 15.w ,right: 15.w),
                              child: DeliverySelector(
                                options: options,
                                onSelected: (index) {
                                  logInfo("Selected Option: ${options[index].title}");
                                  selectedDeliveryOption = options[index].title;
                                },
                              ),
                            ),*/

                            Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 25.h, bottom: 20.h),
                              child: DottedLine(
                                dashColor: Colors.grey.withOpacity(0.25),
                                dashLength: 5,
                                dashGapLength: 3,
                                lineThickness: 2,
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                              child: RatingReviewsWidget(
                                averageRating: 4.0,
                                reviews: reviews,
                                onViewAll: () {
                                  logInfo("Navigate to all reviews");
                                  Navigator.of(context).push(openAnimatedPage(
                                      AllReviewsScreen()
                                  ));
                                },
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                              child: DottedLine(
                                dashColor: Colors.grey.withOpacity(0.25),
                                dashLength: 5,
                                dashGapLength: 3,
                                lineThickness: 2,
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                              child: MostPopularSection(
                                items: [
                                  PopularItem(
                                    imageUrl: "https://www.rollingstone.com/wp-content/uploads/2024/08/Best-Skincare-Brands-for-Men-APSE-Featured.png?w=900&h=600&crop=1",
                                    likes: 1780,
                                    label: "New",
                                  ),
                                  PopularItem(
                                    imageUrl: "https://www.rollingstone.com/wp-content/uploads/2024/08/Best-Skincare-Brands-for-Men-APSE-Featured.png?w=900&h=600&crop=1",
                                    likes: 1780,
                                    label: "Sale",
                                  ),
                                  PopularItem(
                                    imageUrl: "https://www.rollingstone.com/wp-content/uploads/2024/08/Best-Skincare-Brands-for-Men-APSE-Featured.png?w=900&h=600&crop=1",
                                    likes: 1780,
                                    label: "Hot",
                                  ),
                                ],
                                onViewAll: () {
                                  // Navigate to full list
                                },
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                              child: DottedLine(
                                dashColor: Colors.grey.withOpacity(0.25),
                                dashLength: 5,
                                dashGapLength: 3,
                                lineThickness: 2,
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: 5.w,right: 5.w),
                              child: YouMightLikeSection(
                                products: [
                                  ProductModel(
                                    imageUrl: "https://ziedasclinic.com/wp-content/uploads/2024/08/luxury-skin-care-in-dubai.jpg",
                                    description: "Lorem ipsum dolor sit amet consectetur amet...",
                                    price: "₹699",
                                  ),
                                  ProductModel(
                                    imageUrl: "https://ziedasclinic.com/wp-content/uploads/2024/08/luxury-skin-care-in-dubai.jpg",
                                    description: "Lorem ipsum dolor sit amet consectetur amet...",
                                    price: "₹699",
                                  ),
                                  ProductModel(
                                    imageUrl: "https://ziedasclinic.com/wp-content/uploads/2024/08/luxury-skin-care-in-dubai.jpg",
                                    description: "Lorem ipsum dolor sit amet consectetur amet...",
                                    price: "₹699",
                                  ),
                                  ProductModel(
                                    imageUrl: "https://ziedasclinic.com/wp-content/uploads/2024/08/luxury-skin-care-in-dubai.jpg",
                                    description: "Lorem ipsum dolor sit amet consectetur amet...",
                                    price: "₹699",
                                  ),
                                ],
                              ),
                            )



                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.all(12.0.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          favProductWidget(),
                          Row(
                            children: [
                              customSizedBox(width: 10.w),
                              addToCartWidget(),
                              customSizedBox(width: 10.w),
                             // buyNowWidget(),
                              customSizedBox(width: 15.w),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );

            /* return ListView.builder(
             // padding: const EdgeInsets.all(16),
              itemCount: homeData.home.length,
              itemBuilder: (context, index) {
                final section = homeData.home[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (section.displayTitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          section.displayTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    _buildSection(section),
                    const SizedBox(height: 16),
                  ],
                );
              },
            );*/
            }
          },
        )
      ),
    );
  }


  Widget addToCartWidget(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.redAccent,
          border: Border.all(color: Colors.redAccent,width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 20.w,right: 20.w ,top: 8.h,bottom: 8.h),
        child: Text('Add To Cart',style: customTextStyle(color: Colors.white,fontSize: 18.sp)),
      ),
    );
  }

/*  Widget addToCartWidget(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.redAccent,width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 20.w,right: 20.w ,top: 8.h,bottom: 8.h),
        child: Text('Add To Cart',style: customTextStyle(color: Colors.redAccent,fontSize: 18.sp)),
      ),
    );
  }*/







  Widget priceAndDescWidget({required DetailProductPriceDetails? productDetails}){
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: customTextStyle(fontSize: 14, color: Colors.black54),
              children: [
                TextSpan(
                    text: "₹ ",
                    style: customTextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold ,color: Colors.redAccent))
                ,
                TextSpan(
                  text: productDetails?.sellingPrice==null? "": productDetails?.sellingPrice.toString(),
                    style: customTextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold ,color: Colors.redAccent)
                ),
              ],
            ),
          ),
          customSizedBox(height: 10.h),
          Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mauris, scelerisque eu mauris id, pretium pulvinar sapien. pretium pulvinar sapien.',
          style: customTextStyle(color: Colors.black54)
          )
        ],
      ),
    );
  }

  Widget favProductWidget(){
    bool isFav = false;
    return IconButton(onPressed: (){
      setState(() {
        isFav = !isFav;
      });
    }, icon: isFav ?  Icon(Icons.favorite_outlined,color: Colors.redAccent,size: 35.r) : Icon(Icons.favorite_outline,color: Colors.black,size: 35.r,));
  }

}











