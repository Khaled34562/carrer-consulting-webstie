# Dart ServerPod API Documentation

## 1. Comment Endpoint (comment.dart)

Handles operations related to comments.

### Methods:

#### insertComment(Session session, Comment comment) -> Future<Comment>

Inserts a new comment into the database.

- **Parameters:**
  - `comment`: A `Comment` object with `articleId`, `userId`, and `content`.
  - `session`: The current `Session` object.
- **Returns:** The inserted `Comment` object.

#### getCommentsByArticle(Session session, int articleId) -> Future<List<Comment>>

Retrieves all comments for a specific article.

- **Parameters:**
  - `articleId`: The unique identifier of the article.
  - `session`: The current `Session` object.
- **Returns:** A list of `Comment` objects.

#### getCommentsByUser(Session session, int userId) -> Future<List<Comment>>

Retrieves all comments made by a specific user.

- **Parameters:**
  - `userId`: The unique identifier of the user.
  - `session`: The current `Session` object.
- **Returns:** A list of `Comment` objects.

#### deleteComment(Session session, Comment comment) -> Future<Comment>

Deletes a specific comment.

- **Parameters:**
  - `comment`: The `Comment` object to be deleted.
  - `session`: The current `Session` object.
- **Returns:** The deleted `Comment` object.

---

## 2. Article Like Endpoint (article_like.dart)

Handles operations related to article likes.

### Methods:

#### likeArticle(Session session, ArticleLike like) -> Future<ArticleLike>

Likes an article or re-likes it if previously unliked.

- **Parameters:**
  - `like`: An `ArticleLike` object containing `userId` and `articleId`.
  - `session`: The current `Session` object.
- **Returns:** The created `ArticleLike` object.

#### unlikeArticle(Session session, ArticleLike like) -> Future<ArticleLike>

Unlikes an article.

- **Parameters:**
  - `like`: An `ArticleLike` object containing `userId` and `articleId`.
  - `session`: The current `Session` object.
- **Returns:** The deleted `ArticleLike` object.

#### getLikedArticlesByUser(Session session, int userId) -> Future<List<ArticleLike>>

Retrieves all articles liked by a specific user.

- **Parameters:**
  - `userId`: The unique identifier of the user.
  - `session`: The current `Session` object.
- **Returns:** A list of `ArticleLike` objects.

#### getLikeCount(Session session, int articleId) -> Future<int>

Retrieves the total count of likes for a specific article.

- **Parameters:**
  - `articleId`: The unique identifier of the article.
  - `session`: The current `Session` object.
- **Returns:** The total number of likes.

---

## 3. Article Endpoint (article.dart)

Handles operations related to articles.

### Methods:

#### insertArticle(Session session, Article article) -> Future<Article>

Inserts a new article into the database.

- **Parameters:**
  - `article`: The `Article` object containing article details.
  - `session`: The current `Session` object.
- **Returns:** The inserted `Article` object.

#### getRecentArticles(Session session) -> Future<List<Article>>

Retrieves the 10 most recent articles.

- **Parameters:**
  - `session`: The current `Session` object.
- **Returns:** A list of up to 10 `Article` objects.

#### shareArticle(Session session, int articleId) -> Future<Article>

Increments the share count of an article.

- **Parameters:**
  - `articleId`: The unique identifier of the article.
  - `session`: The current `Session` object.
- **Returns:** The updated `Article` object.

#### getArticlesByConsultant(Session session, int userId) -> Future<List<Article>>

Retrieves all articles authored by a specific consultant.

- **Parameters:**
  - `userId`: The unique identifier of the consultant.
  - `session`: The current `Session` object.
- **Returns:** A list of `Article` objects.

#### updateArticle(Session session, Article updatedArticle) -> Future<Article>

Updates an existing article.

- **Parameters:**
  - `updatedArticle`: The updated `Article` object.
  - `session`: The current `Session` object.
- **Returns:** The updated `Article` object.

#### getArticle(Session session, int articleId) -> Future<Article?>

Retrieves a specific article by its ID.

- **Parameters:**
  - `articleId`: The unique identifier of the article.
  - `session`: The current `Session` object.
- **Returns:** The `Article` object if found, otherwise `null`.

#### deleteArticle(Session session, Article article) -> Future<Article>

Deletes an existing article.

- **Parameters:**
  - `article`: The `Article` object to be deleted.
  - `session`: The current `Session` object.
- **Returns:** The deleted `Article` object.

---

## 4. User Profile Endpoint (user_profile.dart)

Handles operations related to user profiles.

### Methods:

#### getUserProfile(Session session, int userId) -> Future<UserProfile?>

Retrieves a user profile by their user ID.

- **Parameters:**
  - `userId`: The unique identifier of the user.
  - `session`: The current `Session` object.
- **Returns:** A `UserProfile` object if found, otherwise `null`.

#### updateUserProfile(Session session, UserProfile updatedUserProfile) -> Future<UserProfile?>

Updates an existing user profile.

- **Parameters:**
  - `updatedUserProfile`: The updated `UserProfile` object.
  - `session`: The current `Session` object.
- **Returns:** The updated `UserProfile` if successful, otherwise `null`.

#### createUserProfile(Session session, UserProfile newUserProfile) -> Future<UserProfile?>

Creates a new user profile.

- **Parameters:**
  - `newUserProfile`: The `UserProfile` object containing new user details.
  - `session`: The current `Session` object.
- **Returns:** The created `UserProfile` if successful, otherwise `null`.

---

**End of Documentation**
