#encoding: utf-8
Factory.define :depart do |depart|
    depart.name  "Test"
end

Factory.define :user do |user|
    user.nickname	                "h02-GerasimovMN"
    user.password              		"Cegth1Yjdsq2Gfhjkm3"
    user.password_confirmation 		"Cegth1Yjdsq2Gfhjkm3"
    user.lastname			"Test"
    user.firstname			"Test"
    user.secondname			"Test"
    user.depart				Factory(:depart)
    user.role				"Пользователь"
    user.is_valid			'Y'
    user.is_not_ad			'N'
    user.type				"User"
end