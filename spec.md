# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    - The parent application controller inherits from Sinatra.
- [x] Use ActiveRecord for storing information in a database
    - All models inherit from ActiveRecord, and ActiveRecord provides macros used by all of the models.
- [x] Include more than one model class (e.g. User, Post, Category)
    - Models are Teacher, Lesson, and Subject. Teacher is the user, and Lesson is the resource. Subjects provide a way to organize both.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    - The Teacher (user) has_many Lessons (resource). Each Subject has_many Teachers and has_many Lessons through Teachers.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    - A Lesson belongs_to a Teacher, and a Teacher belongs_to a Subject.
- [x] Include user accounts with unique login attribute (username or email)
    - Teachers log in with a name and a password. If the user tries to sign up with an existing name, they are redirected to the login route.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    - As long as they are logged in, a Teacher can Create a new Lesson. They can also view any Lesson created by any other Teacher. If they are looking at a Lesson they created, they get the options to Edit or Delete the Lesson. 
- [x] Ensure that users can't modify content created by other users
    - Links to edit or delete are only displayed if the Lesson belongs to that particular teacher. If a different teachers tries to manually access the View to edit that Lesson, they are redirected to the view that simply displays that Lesson instead.
- [x] Include user input validations
    - The app uses the bcrypt gem, and when a user logs in the app runs #authenticate on the instance of the Teacher class and pass the input password as an argument. That method is provided from the has_secure_password macro in the Teacher class.
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
    - Readme is complete.

Confirm
- [x] You have a large number of small Git commits
    - There are 17 commits as of the writing of this form. There will be a few more by the time of submission. I know I could/should have done more, but I get super in the zone when coding. It is something I am working on. This time, I did commits after finishing batches of related code. Next time I know I need to do it every time I finish a small piece.
- [x] Your commit messages are meaningful
    - My messages describe broadly what I did, since I did not do the commits as frequently as I should have.
- [x] You made the changes in a commit that relate to the commit message
    - The commit messages do reflect the changes made by the commit.
- [x] You don't include changes in a commit that aren't related to the commit message
    - It is possible that I did, but I understand that I need to commit after every small change, rather than after groups of changes as I did.
