# Destroy all existing data
Upvote.destroy_all
Contribution.destroy_all
Participation.destroy_all
Project.destroy_all
User.destroy_all

# Companies
companies = [
  {
    company_name: "Uber",
    company: true,
    email: "uber@uber.com",
    password: "123456",
    location: "London, UK",
    description: "Uber Technologies Inc. is a technology company headquartered in San Francisco, California, United States, operating in 570 cities worldwide. It develops, markets and operates the Uber car transportation and food delivery mobile apps. Uber drivers use their own cars, although drivers can rent a car to drive with Uber."
  },
  {
    company_name: "Facebook",
    company: true,
    email: "facebook@facebook.com",
    password: "123456",
    location: "London, UK",
    description: "Facebook is an American for-profit corporation and an online social media and social networking service based in Menlo Park, California. The Facebook website was launched on February 4, 2004, by Mark Zuckerberg, along with fellow Harvard College students and roommates, Eduardo Saverin, Andrew McCollum, Dustin Moskovitz, and Chris Hughes."
  },
  {
    company_name: "Google",
    company: true,
    email: "google@google.com",
    password: "123456",
    location: "London, UK",
    description: "Google is an American multinational technology company specializing in Internet-related services and products. These include online advertising technologies, search, cloud computing, software, and hardware. Google was founded in 1998 by Larry Page and Sergey Brin while they were Ph.D. students at Stanford University, in California."
  }
]

companies.each do |e|
  User.create!(company_name: e[:company_name], company: e[:company], email: e[:email], password: e[:password], location: e[:location], description: e[:description])
end

# Individuals
users = [
  {
    first_name: "Kees",
    last_name: "Postma",
    email: "kk.postma@gmail.com",
    password: "123456",
    location: "London, UK",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Illum esse odit autem hic consectetur laboriosam, optio, dignissimos, perspiciatis labore amet eius saepe cum tempora, placeat quae quisquam fugit itaque eveniet."
  },
  {
    first_name: "James",
    last_name: "Block",
    email: "james@hewines.com",
    password: "123456",
    location: "London, UK",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Illum esse odit autem hic consectetur laboriosam, optio, dignissimos, perspiciatis labore amet eius saepe cum tempora, placeat quae quisquam fugit itaque eveniet."
  },
  {
    first_name: "Rami",
    last_name: "Bakri",
    email: "rbakri1@gmail.com",
    password: "123456",
    location: "London, UK",
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Illum esse odit autem hic consectetur laboriosam, optio, dignissimos, perspiciatis labore amet eius saepe cum tempora, placeat quae quisquam fugit itaque eveniet."
  }
]

users.each do |e|
  individual = User.create!(first_name: e[:first_name], last_name: e[:last_name], email: e[:email], password: e[:password], location: e[:location], description: e[:description])
  Project.all.each do |project|
    Participation.create!(user: individual, project: project)
    Contribution.create!(user: individual, project: project, starred: true, comment: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rem voluptatum, asperiores animi quis quisquam corporis excepturi doloremque quia vitae! Est perspiciatis repellat aut quis veritatis explicabo eligendi, at iusto dolore.")
  end
end

# Projects
projects = [
  {
    user_id: 1,
    title: "The Big Project",
    brief: "This is to address the marketing department's needs to build an audience in China.",
    end_date: (DateTime.now + 5),
    max_participations: 30,
    category: "Marketing"
  },
  {
    user_id: 2,
    title: "Finance investigation",
    brief: "Our annual accounts were out by several million pounds and we're looking for talented mathmeticians to correct this. ",
    end_date: (DateTime.now + 9),
    max_participations: 40,
    category: "Finance"
  },
  {
    user_id: 3,
    title: "Suggestions for improving our internal organisation",
    brief: "We are looking to learn from forward thinking young professionals to understand how we can make the working environment better for them and us.",
    end_date: (DateTime.now + 5),
    max_participations: 30,
    category: "Operations"
  }
]

projects.each do |e|
  Project.create!(user_id: e[:user_id], title: e[:title], brief: e[:brief], end_date: e[:end_date], max_participations: e[:max_participations], category: e[:category])
end

User.all.each do |user|
  if user.is_individual?
    Contribution.all.each do |c|
      Upvote.create!(user: user, contribution: c)
    end
  end
end

