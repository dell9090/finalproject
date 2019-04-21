# INFO6350 FinalProject

HyperGarageSale

## Requirements and Steps
1: HyperGarageSale - Menus and Notifications
(1) Add a SnackBar that comes up when a new post has been added.
(2) Add an Action Bar with a menu item to Post a new item. 

2: BrowsePostActivity
(1) Add a Floating Action Button and navigate from BrowsePosts to NewPost when floating action button is pressed.

3: RecycleView/ListView
(1) Add a RecycleView to BrowsePostsActivity

(2) Create a database to hold new posts data

(3) Integrate RecycleView and corresponding adapter with database to store new posts

4: Camera Interactions
(1) With each new post, allow user to take up to 4 images and attach them 
(2) Application may display thumbnails of those images on the new post form for user to preview them
(3) When user will click on a given post on the ListView, open the post detail view and display post details and associated thumbnails 
(4) When clicked on thumbnail, display full-screen image with back navigation arrow

5: Firebase Integration
(1) Integrate HyperGarageSale application with Firebase Services for the following Authentication, Real-time database(Firestore), Storing and retrieving image files (Storage)

## Project Details
1. This App nick name in Firebase is called Hyper.
2. Use Cloud Firestore as database. The collection name is salelist. The document structure is
        description: String
        photos: Array<String>
        price: String
        title: String
3. The photos are stored in Firebase Storage. the path is /data/.

        
##Screenshots
![browse](https://github.com/dell9090/finalproject/raw/master/Screenshots/browse.png)
![browseDetial](https://github.com/dell9090/finalproject/raw/master/Screenshots/browseDetial.png)
![forgetPassword](https://github.com/dell9090/finalproject/raw/master/Screenshots/forgetPassword.png)
![fullPicture](https://github.com/dell9090/finalproject/raw/master/Screenshots/fullPicture.png)
![post1](https://github.com/dell9090/finalproject/raw/master/Screenshots/post1.png)
![post2](https://github.com/dell9090/finalproject/raw/master/Screenshots/post2.png)
