
import Foundation

struct TeaVariety: Identifiable {
    let id = UUID()
    let tea_name: String
    let region_of_origin: String
    let tsp_per_8_oz: ValueRange
    let traditional_name: String
    let amount_of_caffiene: Int
    let main_tea_type: String
    let number_of_steeps: ValueRange
    let steep_instructions: [SteepInstruction]
    let overall_taste_description: String
    let short_summary: String
    let overall_tea_description: String
}

struct ValueRange: Codable {
    let minimum: Double
    let maximum: Double
}

struct SteepInstruction: Codable {
    let temperature: ValueRange
    let duration: ValueRange
    let steep_number: Int
    let steep_taste_description: String
}

let allTeas: [TeaVariety] = [
    TeaVariety(
        tea_name: "Sencha Green Tea",
        region_of_origin: "Japan",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Sencha",
        amount_of_caffiene: 3,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 158, maximum: 176), duration: ValueRange(minimum: 1, maximum: 1), steep_number: 1, steep_taste_description: "Fresh, grassy, umami, slightly sweet"),
            SteepInstruction(temperature: ValueRange(minimum: 158, maximum: 176), duration: ValueRange(minimum: 0.5, maximum: 0.5), steep_number: 2, steep_taste_description: "Lighter, still fresh and grassy"),
            SteepInstruction(temperature: ValueRange(minimum: 158, maximum: 176), duration: ValueRange(minimum: 1.5, maximum: 1.5), steep_number: 3, steep_taste_description: "Milder, subtle notes")
        ],
        overall_taste_description: "Grassy, fresh, vegetal, umami, sometimes oceanic, nutty, fruity, floral, with notes of sweet corn, edamame, miso soup, and baby spinach.",
        short_summary: "A popular Japanese green tea known for its fresh, grassy, and umami flavor profile, often with a slightly sweet aftertaste.",
        overall_tea_description: "Sencha is the most commonly consumed green tea in Japan, made from tea leaves grown in direct sunlight. It is characterized by its vibrant green color, refreshing aroma, and a balanced flavor that can range from vegetal and grassy to slightly sweet and oceanic, depending on the specific grade and preparation. It is rich in antioxidants and offers various health benefits."
    ),
    TeaVariety(
        tea_name: "Matcha Green Tea",
        region_of_origin: "Japan (originated in China)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Matcha",
        amount_of_caffiene: 4,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Vibrant, vegetal, umami, slightly bitter with a sweet finish")
        ],
        overall_taste_description: "Bright, vegetal, slightly bitter, with notes of sweetness and umami. Can be grassy, earthy, and have a creamy finish, especially ceremonial grade.",
        short_summary: "A finely ground Japanese green tea powder known for its vibrant color, rich umami flavor, and high caffeine content, traditionally prepared by whisking into hot water.",
        overall_tea_description: "Matcha is a powdered green tea that originated in China but was popularized in Japan, particularly in tea ceremonies. It is made from shade-grown tea leaves, which contributes to its vibrant green color and unique flavor profile. Matcha is rich in antioxidants and L-theanine, providing a sustained energy boost without the jitters often associated with coffee."
    ),
    TeaVariety(
        tea_name: "Gyokuro Green Tea",
        region_of_origin: "Japan (primarily Fukuoka, Kyoto, and Mie prefectures)",
        tsp_per_8_oz: ValueRange(minimum: 1.5, maximum: 2),
        traditional_name: "Gyokuro",
        amount_of_caffiene: 4,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 122, maximum: 158), duration: ValueRange(minimum: 1.5, maximum: 3), steep_number: 1, steep_taste_description: "Rich umami, sweet, savory, brothy, smooth"),
            SteepInstruction(temperature: ValueRange(minimum: 122, maximum: 158), duration: ValueRange(minimum: 0.5, maximum: 0.5), steep_number: 2, steep_taste_description: "Still rich, slightly less intense umami"),
            SteepInstruction(temperature: ValueRange(minimum: 122, maximum: 158), duration: ValueRange(minimum: 0.5, maximum: 0.5), steep_number: 3, steep_taste_description: "Lighter, refreshing, subtle sweetness")
        ],
        overall_taste_description: "Deep umami, sweet, savory, brothy, sometimes described as seaweed-like, with a smooth and thick mouthfeel.",
        short_summary: "A highly prized Japanese shade-grown green tea known for its intense umami flavor, sweetness, and smooth texture.",
        overall_tea_description: "Gyokuro, meaning 'jade dew,' is one of Japan's most exquisite green teas. It is cultivated by shading the tea plants for several weeks before harvest, which increases chlorophyll and amino acid content, resulting in a unique rich umami flavor, vibrant green color, and sweet aroma. It is typically brewed at lower temperatures to bring out its delicate characteristics."
    ),
    TeaVariety(
        tea_name: "Dragonwell Green Tea",
        region_of_origin: "Zhejiang Province, China (specifically Longjing Village, Hangzhou)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1.5),
        traditional_name: "Longjing",
        amount_of_caffiene: 3,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 185), duration: ValueRange(minimum: 1.5, maximum: 3), steep_number: 1, steep_taste_description: "Fresh, mellow, crisp, nutty, buttery, sweet"),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 185), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 2, steep_taste_description: "Lighter, still nutty and sweet"),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 185), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 3, steep_taste_description: "Subtle, refreshing, with lingering sweetness")
        ],
        overall_taste_description: "Fresh, mellow, crisp, with a distinctive nutty, buttery, and slightly sweet flavor. Often described with notes of toasted nuts, cereal, peas, and a smooth, velvety texture.",
        short_summary: "A famous pan-roasted Chinese green tea from Hangzhou, known for its distinctive flat leaves and a sweet, nutty, and buttery flavor profile.",
        overall_tea_description: "Dragonwell, or Longjing, is one of China's most renowned green teas, originating from Hangzhou, Zhejiang Province. Its unique flat, sword-like leaves are a result of meticulous pan-firing. The tea is celebrated for its fresh aroma, jade-green liquor, and a complex flavor that combines nutty, buttery, and subtly sweet notes, often with a hint of a fresh, vegetal character. It is a highly sought-after tea due to its rich history and delicate taste."
    ),
    TeaVariety(
        tea_name: "Jasmine Green Tea",
        region_of_origin: "China (primarily Fujian province)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Jasmine Green Tea",
        amount_of_caffiene: 2,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 180), duration: ValueRange(minimum: 2, maximum: 4), steep_number: 1, steep_taste_description: "Delicate, fragrant, floral, subtly sweet"),
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 180), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 2, steep_taste_description: "Lighter floral notes, refreshing")
        ],
        overall_taste_description: "A delicate and fragrant tea with a prominent floral aroma and taste from jasmine blossoms, balanced with the fresh, sometimes slightly grassy notes of green tea. Can be subtly sweet.",
        short_summary: "A popular scented green tea from China, infused with the aroma of jasmine blossoms, offering a delicate floral and refreshing taste.",
        overall_tea_description: "Jasmine Green Tea is a type of scented tea made by infusing green tea leaves with the aroma of jasmine flowers. Originating in China, it is celebrated for its intoxicating floral fragrance and delicate flavor. The green tea base provides a fresh, sometimes slightly vegetal backdrop, which is beautifully complemented by the sweet and aromatic notes of jasmine. It is often enjoyed for its calming properties and refreshing taste."
    ),
    TeaVariety(
        tea_name: "Bancha Green Tea",
        region_of_origin: "Japan (various regions including Shizuoka and Kyoto)",
        tsp_per_8_oz: ValueRange(minimum: 1.5, maximum: 2),
        traditional_name: "Bancha",
        amount_of_caffiene: 1,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 0.5, maximum: 1.5), steep_number: 1, steep_taste_description: "Light, refreshing, grassy, vegetal"),
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 2, steep_taste_description: "Milder, still refreshing, subtle vegetal notes")
        ],
        overall_taste_description: "Light and refreshing with grassy, vegetal notes, sometimes described with hints of celery, wet wood, seaweed, mandarin orange, or lemon. It has a mild, sometimes slightly assertive flavor.",
        short_summary: "A common Japanese green tea harvested from later flushes, known for its lower caffeine content and light, refreshing, and vegetal flavor.",
        overall_tea_description: "Bancha is a Japanese green tea harvested from the second flush of sencha, typically in summer or autumn. It is characterized by its larger, more mature leaves and stems, which contribute to its lower caffeine content compared to other green teas like Sencha or Gyokuro. Bancha offers a light, refreshing, and often grassy or vegetal flavor, making it a popular everyday tea in Japan."
    ),
    TeaVariety(
        tea_name: "Gunpowder Green Tea",
        region_of_origin: "China (primarily Zhejiang, Anhui, and Hubei provinces)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Zhū Chá (Pearl Tea)",
        amount_of_caffiene: 3,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 195), duration: ValueRange(minimum: 1, maximum: 3), steep_number: 1, steep_taste_description: "Bold, smoky, nutty, slightly bitter"),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 195), duration: ValueRange(minimum: 2, maximum: 4), steep_number: 2, steep_taste_description: "Milder, still smoky and nutty"),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 195), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 3, steep_taste_description: "Very mild, subtle notes")
        ],
        overall_taste_description: "Bold, smoky, and nutty, often with a slightly bitter finish. The flavor can be described as robust and sometimes with a hint of roasted notes.",
        short_summary: "A Chinese green tea characterized by its tightly rolled, pellet-like leaves resembling gunpowder, offering a bold, smoky, and nutty flavor.",
        overall_tea_description: "Gunpowder tea is a distinctive Chinese green tea where each leaf is rolled into a small, shiny pellet, resembling gunpowder. This rolling process helps to preserve the tea's flavor and aroma. It typically yields a bold, smoky, and sometimes nutty brew with a slightly bitter undertone. It is a versatile tea that can be enjoyed on its own or used as a base for flavored teas, such as Moroccan mint tea."
    ),
    TeaVariety(
        tea_name: "Hojicha Green Tea",
        region_of_origin: "Kyoto, Japan",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Hojicha",
        amount_of_caffiene: 1,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 212), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 1, steep_taste_description: "Toasty, nutty, caramel, mild, sweet"),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 212), duration: ValueRange(minimum: 1.5, maximum: 3), steep_number: 2, steep_taste_description: "Lighter toastiness, subtle sweetness")
        ],
        overall_taste_description: "Distinctively roasted, with a nutty, toasty, and often caramel-like flavor. It has a mild, sweet taste with very low astringency, sometimes described with hints of chocolate or earthy notes.",
        short_summary: "A Japanese green tea that is roasted over charcoal, giving it a unique reddish-brown color and a distinctive nutty, toasty flavor with very low caffeine.",
        overall_tea_description: "Hojicha is a Japanese green tea that stands out due to its roasting process, typically over charcoal. This roasting gives the tea a distinctive reddish-brown color and a unique nutty, toasty aroma and flavor, often with notes of caramel. The roasting process also significantly reduces its caffeine content, making it a popular choice for evening consumption or for those sensitive to caffeine. It is known for its mildness and low astringency."
    ),
    TeaVariety(
        tea_name: "Genmaicha Green Tea",
        region_of_origin: "Japan (various regions including Kyoto, Shizuoka, and Kagoshima)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Genmaicha",
        amount_of_caffiene: 1,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 176, maximum: 212), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Nutty, roasted, slightly sweet, savory"),
            SteepInstruction(temperature: ValueRange(minimum: 176, maximum: 212), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 2, steep_taste_description: "Milder nutty and roasted notes, refreshing"),
            SteepInstruction(temperature: ValueRange(minimum: 176, maximum: 212), duration: ValueRange(minimum: 1.5, maximum: 3), steep_number: 3, steep_taste_description: "Subtle, light, comforting")
        ],
        overall_taste_description: "A unique blend of green tea and roasted brown rice, offering a nutty, toasty, and slightly sweet flavor with a savory undertone. Often described with notes of popcorn or toasted grains.",
        short_summary: "A Japanese green tea blended with roasted brown rice, known for its distinctive nutty aroma and savory, comforting flavor.",
        overall_tea_description: "Genmaicha is a traditional Japanese green tea made by combining green tea leaves (often Sencha or Bancha) with roasted brown rice. Some of the rice grains may pop during the roasting process, giving it the nickname 'popcorn tea.' This blend results in a unique flavor profile that is nutty, warm, and slightly savory, with a comforting aroma. It has a lower caffeine content than pure green teas, making it a popular choice for any time of day."
    ),
    TeaVariety(
        tea_name: "Anji Bai Cha Green Tea",
        region_of_origin: "Anji County, Zhejiang Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Anji Bai Cha",
        amount_of_caffiene: 1,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Sweet, delicate, fresh, floral, nutty, citrus"),
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 2, steep_taste_description: "Lighter, still sweet and floral, refreshing"),
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 1.5, maximum: 3), steep_number: 3, steep_taste_description: "Subtle, clean, with lingering sweetness")
        ],
        overall_taste_description: "Known for its delicate, sweet, and fresh flavor profile with prominent floral notes, often described as reminiscent of morning dew or a spring meadow. It can also have hints of citrus and nuttiness, with a very smooth and clean finish.",
        short_summary: "A rare and highly prized Chinese green tea from Zhejiang province, known for its unique pale leaves and exceptionally sweet, delicate, and floral flavor.",
        overall_tea_description: "Anji Bai Cha, despite its name meaning 'white tea,' is a type of green tea from Anji County in Zhejiang Province, China. It is distinguished by its unique 'white leaf' cultivar, which produces pale, almost white leaves during early spring. This tea is celebrated for its exceptionally delicate, sweet, and fresh flavor, often with pronounced floral and sometimes nutty or citrus notes. It has a naturally low caffeine content and is rich in amino acids, contributing to its smooth and mellow character."
    ),
    TeaVariety(
        tea_name: "Mao Feng Green Tea",
        region_of_origin: "Huangshan (Yellow Mountain), Anhui Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Huangshan Maofeng",
        amount_of_caffiene: 2,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 155, maximum: 185), duration: ValueRange(minimum: 2, maximum: 3), steep_number: 1, steep_taste_description: "Fresh, clean, smooth, sweet floral, mellow, savory, vegetal"),
            SteepInstruction(temperature: ValueRange(minimum: 155, maximum: 185), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 2, steep_taste_description: "Lighter, still fresh and floral, subtle sweetness"),
            SteepInstruction(temperature: ValueRange(minimum: 155, maximum: 185), duration: ValueRange(minimum: 1.5, maximum: 2.5), steep_number: 3, steep_taste_description: "Very mild, refreshing, clean finish")
        ],
        overall_taste_description: "Fresh, clean, and smooth with a sweet floral aroma and a mellow, savory, vegetal flavor. Often described with notes of sugar snap peas, butter, and a hint of spice. It is known for its light and refreshing character.",
        short_summary: "A famous Chinese green tea from Huangshan, known for its delicate, fresh, and sweet floral notes with a clean finish.",
        overall_tea_description: "Mao Feng, particularly Huangshan Maofeng, is one of China's most celebrated green teas, originating from the Yellow Mountains in Anhui Province. It is characterized by its slightly curled, yellowish-green leaves with fine white hairs. The tea offers a fresh, clean, and smooth taste with a distinctive sweet floral aroma and a mellow, savory, and vegetal flavor. It is prized for its delicate profile and lack of bitterness, even with longer steeping times."
    ),
    TeaVariety(
        tea_name: "Bi Luo Chun Green Tea",
        region_of_origin: "Dongting Mountain, Jiangsu Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Bi Luo Chun (Green Snail Spring)",
        amount_of_caffiene: 3,
        main_tea_type: "Green",
        number_of_steeps: ValueRange(minimum: 2, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Strong fruity and floral aroma, gentle yet full sweet flavor, fresh cut grass, melon"),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 2, steep_taste_description: "Lighter floral and fruity notes, still sweet"),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 1.5, maximum: 3), steep_number: 3, steep_taste_description: "Subtle, refreshing, clean finish")
        ],
        overall_taste_description: "Known for its strong fruity and floral aroma, often described with notes of fresh cut grass, sweet hay, apple, and melon. It has a gentle yet full sweet flavor with a clean, crisp finish.",
        short_summary: "A famous Chinese green tea characterized by its tightly curled leaves resembling snails, offering a strong fruity and floral aroma with a sweet and mellow taste.",
        overall_tea_description: "Bi Luo Chun, meaning 'Green Snail Spring,' is a highly acclaimed Chinese green tea from the Dongting Mountain region in Jiangsu Province. Its distinctive appearance comes from its tightly curled, snail-like leaves, often covered in fine white hairs. The tea is celebrated for its intense fruity and floral aroma, often compared to peaches or apricots, and a sweet, mellow taste with a refreshing, lingering aftertaste. It is typically harvested in early spring, yielding a delicate and complex brew."
    ),
    TeaVariety(
        tea_name: "Assam Black Tea",
        region_of_origin: "Assam, India",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Assam",
        amount_of_caffiene: 4,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Strong, malty, brisk")
        ],
        overall_taste_description: "Bold, malty, and brisk with a rich, robust flavor. Often described as having notes of caramel, chocolate, or dried fruit.",
        short_summary: "A strong, malty black tea from India, known for its robust flavor and high caffeine content.",
        overall_tea_description: "Assam tea is a black tea named after the Assam region in India, where it is grown. It is known for its distinctive malty flavor, strong body, and bright color. Assam tea is often used in breakfast tea blends due to its invigorating properties and high caffeine content. It can be enjoyed with milk and sugar."
    ),
    TeaVariety(
        tea_name: "Darjeeling Black Tea",
        region_of_origin: "Darjeeling, West Bengal, India",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Darjeeling",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 185), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Light, floral, muscatel notes")
        ],
        overall_taste_description: "Delicate and complex with floral, fruity (muscatel), and sometimes spicy notes. Often described as having a 'champagne-like' quality.",
        short_summary: "A highly prized black tea from India, known for its delicate flavor and muscatel notes, often called the 'Champagne of Teas'.",
        overall_tea_description: "Darjeeling tea is grown in the Darjeeling district of West Bengal, India. It is renowned for its unique and delicate flavor profile, often referred to as the 'muscatel' flavor, which is a distinctive fruity and floral note. Darjeeling teas are often categorized by 'flushes' (harvest periods), each offering a slightly different character. It can be enjoyed on its own without milk or sugar."
    ),
    TeaVariety(
        tea_name: "Nilgiri Black Tea",
        region_of_origin: "Nilgiri Mountains, Southern India",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Nilgiri",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 190, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Bright, clean, brisk, with notes of citrus and fruit")
        ],
        overall_taste_description: "Bright, clean, and brisk with a smooth, mellow flavor. Often described as having notes of citrus, fruit, and a hint of mint.",
        short_summary: "A refreshing black tea from Southern India, known for its bright, clean flavor and smooth finish.",
        overall_tea_description: "Nilgiri tea is grown in the Nilgiri Mountains of Southern India, often referred to as the \"Blue Mountains\". It is known for its consistent quality throughout the year due to the region's unique climate. Nilgiri teas are typically bright, clean, and brisk, making them excellent for iced tea or as a base for blends. They offer a smooth taste with notes of citrus and fruit, and are less astringent than some other black teas."
    ),
    TeaVariety(
        tea_name: "Ceylon Black Tea",
        region_of_origin: "Sri Lanka (formerly Ceylon)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Ceylon",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Brisk, bold, with notes of citrus and spice")
        ],
        overall_taste_description: "Brisk, bold, and full-bodied with a clean finish. Depending on the region, it can have notes of citrus, chocolate, or spice.",
        short_summary: "A diverse black tea from Sri Lanka, known for its briskness and wide range of flavors depending on its growing region.",
        overall_tea_description: "Ceylon tea refers to teas produced in Sri Lanka, formerly known as Ceylon. It encompasses a wide variety of black, green, and white teas, though black Ceylon is the most common. The flavor profile varies significantly based on the altitude and region of cultivation, ranging from light and floral to strong and malty. Generally, Ceylon black teas are known for their briskness and bright, clean taste, often with citrusy undertones. It is a popular choice for iced tea and blends."
    ),
    TeaVariety(
        tea_name: "Keemun Black Tea",
        region_of_origin: "Qimen County, Anhui Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Keemun",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Malty, fruity, with hints of pine and orchid")
        ],
        overall_taste_description: "Smooth, malty, and slightly smoky with hints of fruit, orchid, and sometimes cocoa. It has a complex and nuanced flavor.",
        short_summary: "A famous Chinese black tea known for its distinctive aroma, often described as having notes of orchid and a hint of smoke.",
        overall_tea_description: "Keemun tea is a renowned black tea from Qimen County in Anhui Province, China. It is celebrated for its unique \"Keemun aroma,\" which is often compared to orchid or floral notes, with a subtle hint of smoke or pine. The tea brews to a reddish-brown liquor and offers a smooth, mellow taste with a lingering sweetness. It is a versatile tea that can be enjoyed on its own or with a touch of milk."
    ),
    TeaVariety(
        tea_name: "Lapsang Souchong Black Tea",
        region_of_origin: "Wuyi Mountains, Fujian Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Lapsang Souchong (Zhengshan Xiaozhong)",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 212), duration: ValueRange(minimum: 2, maximum: 5), steep_number: 1, steep_taste_description: "Strongly smoky, with notes of pine and wood")
        ],
        overall_taste_description: "Distinctively smoky, with a rich, robust flavor often compared to wood smoke, pine, or even whiskey. Some variations may have underlying sweet or malty notes.",
        short_summary: "A unique Chinese black tea famous for its intense smoky aroma and flavor, achieved through pine wood smoking.",
        overall_tea_description: "Lapsang Souchong is a black tea originating from the Wuyi Mountains in Fujian Province, China. Its most distinctive characteristic is its smoky flavor, which is imparted during the drying process by smoking the tea leaves over pine wood fires. This gives the tea a bold and robust taste, often described as having notes of wood smoke, pine, and sometimes a hint of sweetness. It is a tea that evokes strong opinions and is often enjoyed by those who appreciate its unique and assertive character."
    ),
    TeaVariety(
        tea_name: "Yunnan (Dianhong) Black Tea",
        region_of_origin: "Yunnan Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Dianhong",
        amount_of_caffiene: 4,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 185, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Malty, sweet, with notes of chocolate and sometimes spice")
        ],
        overall_taste_description: "Smooth, malty, and sweet with a rich, full-bodied flavor. Often has notes of chocolate, caramel, and sometimes a hint of spice or fruit.",
        short_summary: "A high-quality Chinese black tea from Yunnan, known for its malty sweetness and golden tips.",
        overall_tea_description: "Yunnan tea, also known as Dianhong, is a black tea produced in the Yunnan Province of China. It is characterized by its abundance of golden tips (buds), which contribute to its smooth, malty, and sweet flavor. Dianhong teas are known for their rich, full-bodied liquor and often have notes of chocolate, caramel, or even a subtle spiciness. It is a popular choice for those who enjoy a robust yet smooth black tea."
    ),
    TeaVariety(
        tea_name: "Kenyan Black Tea",
        region_of_origin: "Kenya",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1.5),
        traditional_name: "Kenyan",
        amount_of_caffiene: 4,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 2, maximum: 5), steep_number: 1, steep_taste_description: "Brisk, bold, and full-bodied")
        ],
        overall_taste_description: "Brisk, bold, and full-bodied with a bright, coppery liquor. Often described as having a clean, refreshing taste, sometimes with notes of citrus or a slightly floral aroma.",
        short_summary: "A strong and brisk black tea from Kenya, often used in breakfast blends due to its robust flavor.",
        overall_tea_description: "Kenyan tea is primarily black tea, known for its bright color, brisk flavor, and strong character. Most Kenyan tea is produced using the CTC (Crush, Tear, Curl) method, which results in a consistent and quick-brewing tea. Grown in the highlands of Kenya, these teas are often used in breakfast blends and are well-suited for drinking with milk and sugar. While black tea is the most common, Kenya also produces some green and purple teas."
    ),
    TeaVariety(
        tea_name: "Turkish (Rize) Black Tea",
        region_of_origin: "Rize Province, Turkey",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1.5),
        traditional_name: "Çay (Rize tea)",
        amount_of_caffiene: 4,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 10, maximum: 15), steep_number: 1, steep_taste_description: "Strong, bold, and slightly bitter, often with earthy notes")
        ],
        overall_taste_description: "Strong, bold, and robust with a distinctive earthy and sometimes slightly bitter taste. It is typically consumed without milk, often with sugar cubes.",
        short_summary: "A strong black tea from Turkey, traditionally prepared in a double teapot and known for its robust flavor.",
        overall_tea_description: "Turkish tea, or Çay, is a black tea primarily grown in the Rize Province on the Black Sea coast of Turkey. It is traditionally prepared in a unique double teapot called a çaydanlık, where the tea is brewed as a strong concentrate in the upper pot and diluted with hot water from the lower pot. Rize tea is known for its bold, robust flavor and is a staple of Turkish culture, consumed throughout the day, often with sugar but without milk."
    ),
    TeaVariety(
        tea_name: "Nepalese Tea",
        region_of_origin: "Nepal",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1.5),
        traditional_name: "Nepali Chiya",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Bright, floral, and malty, often with notes of caramel or honey")
        ],
        overall_taste_description: "Bright, floral, and often malty, with a complex flavor profile that can include notes of caramel, honey, and a hint of fruit. It is often compared to Darjeeling tea due to similar growing conditions.",
        short_summary: "A high-quality tea from Nepal, known for its bright, floral notes and often compared to Darjeeling tea.",
        overall_tea_description: "Nepalese tea, often referred to as Nepali Chiya, is grown in the high-altitude regions of Nepal, sharing a similar terroir with Darjeeling. It produces a bright, floral, and often malty cup, with a complex flavor profile that can include notes of caramel, honey, and a hint of fruit. While black tea is the most common, Nepal also produces green, oolong, and white teas. It is gaining recognition for its unique characteristics and high quality."
    ),
    TeaVariety(
        tea_name: "English Breakfast Tea",
        region_of_origin: "Blended (Assam, Ceylon, Kenyan)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "English Breakfast",
        amount_of_caffiene: 4,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Strong, robust, malty, and sometimes slightly bitter")
        ],
        overall_taste_description: "Strong, robust, and full-bodied with a malty flavor. It is designed to be invigorating and pairs well with milk and sugar.",
        short_summary: "A classic blend of black teas, known for its strong, robust flavor, traditionally enjoyed with breakfast.",
        overall_tea_description: "English Breakfast tea is a traditional blend of black teas, typically originating from Assam, Ceylon, and Kenya. It is known for its strong, robust, and full-bodied flavor, making it a popular choice to start the day. The blend is designed to be invigorating and is commonly consumed with milk and sugar. The exact composition of English Breakfast tea can vary between different brands, but the goal is always a rich and satisfying cup."
    ),
    TeaVariety(
        tea_name: "Irish Breakfast Tea",
        region_of_origin: "Blended (Assam, Ceylon, Kenyan)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Irish Breakfast",
        amount_of_caffiene: 5,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Very strong, malty, and robust")
        ],
        overall_taste_description: "Very strong, robust, and malty, often with a rich, deep flavor. It is designed to be a potent morning tea, typically enjoyed with milk and sugar.",
        short_summary: "A very strong and malty black tea blend, popular in Ireland for its invigorating properties.",
        overall_tea_description: "Irish Breakfast tea is a blend of black teas, predominantly Assam, often with contributions from Ceylon and Kenyan teas. It is known for being even stronger and more robust than English Breakfast tea, with a pronounced malty flavor. This blend is designed to be a hearty morning tea, capable of standing up to milk and sugar, and providing a significant caffeine boost to start the day."
    ),
    TeaVariety(
        tea_name: "Scottish Breakfast Tea",
        region_of_origin: "Blended (Assam, Ceylon, Kenyan, sometimes Chinese)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Scottish Breakfast",
        amount_of_caffiene: 5,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 205, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Very strong, malty, and robust, often with a smoky or earthy undertone")
        ],
        overall_taste_description: "Extremely strong, robust, and malty, often with a more pronounced smoky or earthy character than other breakfast blends. It is designed to be a very hearty tea, typically consumed with milk and sugar.",
        short_summary: "A very strong and full-bodied black tea blend, known for its intense flavor, popular in Scotland.",
        overall_tea_description: "Scottish Breakfast tea is a blend of black teas, often with a higher proportion of Assam teas, and sometimes including teas from Ceylon, Kenya, and even China. It is renowned for being the strongest and most full-bodied of the breakfast tea blends, designed to stand up to the soft water prevalent in Scotland. It offers a rich, malty flavor, often with a slightly smoky or earthy undertone, and is traditionally enjoyed with milk and sugar."
    ),
    TeaVariety(
        tea_name: "Russian Caravan Tea",
        region_of_origin: "Blended (China, India, Formosa)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Russian Caravan",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Smoky, malty, and sweet, with a hint of dried fruit")
        ],
        overall_taste_description: "A complex blend with a distinctive smoky aroma and flavor, balanced by malty sweetness and sometimes notes of dried fruit. The smokiness is less intense than Lapsang Souchong.",
        short_summary: "A blended black tea with a smoky aroma, reminiscent of the teas transported by camel caravans from China to Russia.",
        overall_tea_description: "Russian Caravan tea is a blend of black teas, often including Lapsang Souchong, Keemun, and Oolong, designed to evoke the smoky flavor of teas transported by camel caravans along the ancient tea routes from China to Russia. The journey itself was said to impart a smoky character to the tea. It offers a balanced flavor profile with a distinctive smoky note, complemented by malty and sweet undertones. It is a popular choice for those who enjoy a smoky tea but find Lapsang Souchong too intense."
    ),
    TeaVariety(
        tea_name: "Chai (Masala Chai)",
        region_of_origin: "Indian Subcontinent",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Masala Chai",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 4, maximum: 6), steep_number: 1, steep_taste_description: "Spicy, sweet, creamy, with strong black tea notes")
        ],
        overall_taste_description: "Aromatic and flavorful, with a dominant blend of spices (ginger, cardamom, cinnamon, cloves, black pepper) balanced by strong black tea and often sweetened with milk and sugar.",
        short_summary: "A spiced milk tea from the Indian subcontinent, known for its warming and aromatic blend of black tea and various spices.",
        overall_tea_description: "Chai, or Masala Chai, is a traditional spiced tea beverage originating from the Indian subcontinent. It is made by brewing black tea with a mixture of aromatic Indian spices, typically including ginger, cardamom, cinnamon, cloves, and black pepper. It is commonly prepared with milk and sweetened, offering a warming, invigorating, and flavorful experience. The exact blend of spices can vary regionally and personally, leading to a diverse range of taste profiles."
    ),
    TeaVariety(
        tea_name: "Earl Grey Black Tea",
        region_of_origin: "Blended (various, flavored in UK)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Earl Grey",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 208), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Citrusy, floral, with a brisk black tea base")
        ],
        overall_taste_description: "Distinctive citrusy flavor from bergamot oil, balanced with a brisk and sometimes malty black tea base. It is aromatic and refreshing.",
        short_summary: "A popular black tea flavored with bergamot oil, known for its distinctive citrus aroma and taste.",
        overall_tea_description: "Earl Grey tea is a black tea blend flavored with oil of bergamot, an aromatic citrus fruit. The tea is named after Charles Grey, 2nd Earl Grey, British Prime Minister in the 1830s. While the exact origin is debated, it is widely associated with British tea culture. The base tea is typically a black tea from China, India, or Sri Lanka. Earl Grey is cherished for its distinctive citrusy aroma and flavor, making it a popular choice for both morning and afternoon tea, often enjoyed with or without milk and sugar."
    ),
    TeaVariety(
        tea_name: "Lady Grey Black Tea",
        region_of_origin: "Blended (various, created in UK)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Lady Grey",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 208), duration: ValueRange(minimum: 2, maximum: 4), steep_number: 1, steep_taste_description: "Citrusy, floral, with notes of orange and lemon")
        ],
        overall_taste_description: "A lighter and more delicate version of Earl Grey, with prominent notes of orange and lemon peel alongside the bergamot, resulting in a brighter and more floral citrus flavor.",
        short_summary: "A variation of Earl Grey tea with added orange and lemon peel, offering a lighter and more floral citrus flavor.",
        overall_tea_description: "Lady Grey tea is a trademarked variation of Earl Grey tea, created by Twinings. It is a black tea flavored with bergamot oil, but with the addition of orange and lemon peel. This gives Lady Grey a lighter, brighter, and more floral citrus aroma and taste compared to the more intense bergamot of traditional Earl Grey. It is often enjoyed by those who prefer a less assertive citrus flavor or a more nuanced aromatic experience."
    ),
    TeaVariety(
        tea_name: "Prince of Wales Black Tea",
        region_of_origin: "Blended (China)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Prince of Wales",
        amount_of_caffiene: 3,
        main_tea_type: "Black",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 3, maximum: 5), steep_number: 1, steep_taste_description: "Light, smooth, and mellow, with a hint of floral notes")
        ],
        overall_taste_description: "Light, smooth, and mellow with a delicate flavor profile. It is less robust than other breakfast teas, often with subtle floral or fruity notes.",
        short_summary: "A delicate and smooth Chinese black tea blend, traditionally enjoyed in the afternoon.",
        overall_tea_description: "Prince of Wales tea is a blend of Chinese black teas, typically from the Hunan, Jiangxi, Anhui, and Yunnan provinces. It was originally blended by Twinings for Edward, Prince of Wales (later King Edward VIII) in 1921. This tea is known for its light, smooth, and mellow character, making it a more delicate option compared to the stronger breakfast blends. It is often enjoyed in the afternoon, with or without milk and sugar, and is appreciated for its subtle floral and sometimes fruity notes."
    ),
    TeaVariety(
        tea_name: "Chamomile Tea",
        region_of_origin: "Europe, Middle East, Asia, Egypt",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "German Chamomile, Roman Chamomile, Hungarian Chamomile, Ground Apple (from Greek etymology)",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 194, maximum: 212), duration: ValueRange(minimum: 5, maximum: 15), steep_number: 1, steep_taste_description: "Mild, floral, slightly sweet with apple notes. Longer steeping increases intensity.")
        ],
        overall_taste_description: "Delicate, floral, with hints of sweetness and earthiness, often described as soothing and calming. Can have subtle apple notes.",
        short_summary: "A popular herbal tea known for its calming properties, often used to aid sleep and digestion. It is naturally caffeine-free and has a mild, floral taste.",
        overall_tea_description: "Chamomile tea is an herbal infusion made from the dried flowers of the chamomile plant. It has been used for centuries in traditional medicine for its soothing and relaxing effects. It is naturally caffeine-free, making it an ideal beverage for evening consumption. The flavor profile is generally mild, floral, and slightly sweet, with some varieties exhibiting subtle apple-like notes. It is widely consumed for its potential benefits in reducing anxiety, improving sleep quality, and aiding digestion."
    ),
    TeaVariety(
        tea_name: "Peppermint Tea",
        region_of_origin: "Europe, Middle East (widely cultivated globally, notably in the Pacific Northwest USA and Maghreb region of Africa)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "American Mint, Balm Mint, Brandy Mint, Curled Mint, Lamb Mint, Maghrebi Mint Tea (in North Africa)",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 190, maximum: 212), duration: ValueRange(minimum: 3, maximum: 15), steep_number: 1, steep_taste_description: "Fresh, cooling mint. Longer steeping can result in a stronger, more intense mint flavor.")
        ],
        overall_taste_description: "Crisp, clean, and refreshing with a strong, cooling mint flavor. Can have a slightly sweet and sometimes earthy undertone.",
        short_summary: "A popular herbal tea known for its refreshing taste and digestive benefits. It is naturally caffeine-free and offers a cooling sensation.",
        overall_tea_description: "Peppermint tea is an herbal infusion made from the dried leaves of the peppermint plant. It is widely consumed for its refreshing taste and its traditional use in aiding digestion, relieving headaches, and soothing upset stomachs. It is naturally caffeine-free, making it a suitable beverage at any time of day. The flavor is characterized by a strong, crisp, and cooling mint sensation, often with a slightly sweet or earthy finish."
    ),
    TeaVariety(
        tea_name: "Ginger Tea",
        region_of_origin: "Southeast Asia (widely cultivated in India, China, Brazil, Jamaica)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Shōgayu (Japanese), Saenggang-cha (Korean), Teh Halia (Malay), Teh Jahe (Indonesian), Salabat (Filipino), Té de Jengibre (Spanish)",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 212), duration: ValueRange(minimum: 5, maximum: 20), steep_number: 1, steep_taste_description: "Spicy, warming, and pungent. Longer steeping increases the intensity and peppery notes.")
        ],
        overall_taste_description: "Pungent, spicy, and warming with a slightly sweet and peppery flavor. Can have citrusy undertones, especially when fresh ginger is used.",
        short_summary: "A warming herbal tea made from ginger root, known for its spicy flavor and traditional use in aiding digestion and soothing nausea. It is naturally caffeine-free.",
        overall_tea_description: "Ginger tea is a herbal beverage made from the rhizome of the ginger plant. It has a long history of use in traditional medicine, particularly in East and Southeast Asia, for its warming properties and its effectiveness in alleviating nausea, indigestion, and inflammation. The tea is naturally caffeine-free and offers a distinct spicy, pungent, and warming flavor, which can be intensified by longer steeping times or by using fresh ginger."
    ),
    TeaVariety(
        tea_name: "Hibiscus (Rosella) Tea",
        region_of_origin: "West Africa (widely cultivated in tropical and subtropical regions globally, including Mexico, Central and South America, and the Caribbean)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Karkadé (Egypt, Sudan), Agua de Jamaica (Mexico, Central America), Sorrel (Caribbean), Roselle",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 190, maximum: 212), duration: ValueRange(minimum: 5, maximum: 10), steep_number: 1, steep_taste_description: "Tart, cranberry-like, with fruity and slightly sweet undertones. Longer steeping can increase tartness.")
        ],
        overall_taste_description: "Vibrant, tart, and fruity, often compared to cranberry, with a refreshing and slightly sweet finish. It has a distinctive deep red color.",
        short_summary: "A bright red herbal tea made from the dried calyces of the hibiscus flower, known for its tart flavor and potential health benefits, including lowering blood pressure. It is naturally caffeine-free.",
        overall_tea_description: "Hibiscus tea is a popular herbal infusion made from the dried calyces of the Hibiscus sabdariffa flower. It is renowned for its striking deep red color and its distinctive tart, cranberry-like flavor, often with fruity and subtly sweet notes. Naturally caffeine-free, it is enjoyed both hot and cold and is traditionally consumed in various cultures for its refreshing qualities and potential health benefits, such as supporting cardiovascular health and providing antioxidants."
    ),
    TeaVariety(
        tea_name: "Rooibos (Red) Tea",
        region_of_origin: "Cederberg region of South Africa",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Red Bush Tea, Red Tea (from Afrikaans 'rooibos' meaning 'red bush')",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 2),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 200, maximum: 212), duration: ValueRange(minimum: 5, maximum: 10), steep_number: 1, steep_taste_description: "Full-bodied, earthy, and naturally sweet with notes of honey, vanilla, and caramel. Does not become bitter with longer steeping.")
        ],
        overall_taste_description: "Naturally sweet, earthy, and full-bodied with hints of honey, vanilla, and caramel. It has a smooth, mellow flavor that is not bitter.",
        short_summary: "A caffeine-free herbal tea from South Africa, known for its distinctive red color, naturally sweet flavor, and antioxidant properties. It is a popular alternative to black tea.",
        overall_tea_description: "Rooibos tea, also known as red bush tea, is a herbal infusion derived from the Aspalathus linearis plant, native exclusively to the Cederberg region of South Africa. It is naturally caffeine-free and low in tannins, making it a smooth and mellow beverage. Rooibos is characterized by its distinctive red color and a naturally sweet, earthy flavor with notes of honey, vanilla, and caramel. Unlike traditional teas, rooibos does not become bitter with prolonged steeping, allowing for a rich and flavorful brew."
    ),
    TeaVariety(
        tea_name: "Lavender Tea",
        region_of_origin: "Mediterranean region (particularly France, Greece, Italy)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "True Lavender, English Lavender, Garden Lavender",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 185, maximum: 212), duration: ValueRange(minimum: 5, maximum: 10), steep_number: 1, steep_taste_description: "Floral, slightly sweet, and aromatic. Can become strong and slightly bitter if oversteeped.")
        ],
        overall_taste_description: "Distinctly floral, aromatic, and slightly sweet with a soothing, calming essence. Can have hints of rosemary and mint.",
        short_summary: "A fragrant herbal tea made from lavender flowers, known for its calming and relaxing properties, often used to promote sleep and reduce anxiety. It is naturally caffeine-free.",
        overall_tea_description: "Lavender tea is an herbal infusion made from the dried flowers of the lavender plant, primarily Lavandula angustifolia. Originating from the Mediterranean region, it has been used for centuries for its aromatic and therapeutic qualities. This naturally caffeine-free tea is widely consumed for its calming and relaxing effects, often aiding in stress reduction and sleep improvement. Its flavor profile is distinctly floral, slightly sweet, and highly aromatic, though it can become strong and slightly bitter if oversteeped."
    ),
    TeaVariety(
        tea_name: "Turmeric Tea",
        region_of_origin: "Indian subcontinent and Southeast Asia",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Haldi Doodh (Golden Milk - often includes turmeric), Yu Jin (Chinese)",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 212), duration: ValueRange(minimum: 5, maximum: 15), steep_number: 1, steep_taste_description: "Earthy, warm, and slightly bitter with peppery notes. Longer steeping enhances the spice and earthiness.")
        ],
        overall_taste_description: "Earthy, warm, and subtly spicy with a slight bitterness and peppery undertones. Often described as having a rich, golden flavor.",
        short_summary: "A vibrant yellow herbal tea made from the turmeric root, known for its anti-inflammatory properties and earthy, warm flavor. It is naturally caffeine-free.",
        overall_tea_description: "Turmeric tea is a herbal infusion made from the rhizome of the Curcuma longa plant, native to the Indian subcontinent and Southeast Asia. It is widely recognized for its vibrant golden color and its potent anti-inflammatory and antioxidant properties, attributed to its active compound, curcumin. This naturally caffeine-free tea has an earthy, warm, and subtly spicy flavor, often with a slight bitterness and peppery notes. It is a popular beverage in traditional medicine systems like Ayurveda and is consumed for overall wellness."
    ),
    TeaVariety(
        tea_name: "Echinacea Tea",
        region_of_origin: "Eastern and Central North America",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Purple Coneflower, American Coneflower",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 212), duration: ValueRange(minimum: 5, maximum: 15), steep_number: 1, steep_taste_description: "Mild, earthy, and slightly floral with a subtle tingling sensation. Longer steeping can increase earthiness.")
        ],
        overall_taste_description: "Mild, earthy, and slightly floral, often with a unique tingling sensation on the tongue. It has a clean and sometimes subtly sweet finish.",
        short_summary: "A popular herbal tea made from the echinacea plant, primarily known for its immune-boosting properties and its use in traditional medicine to combat colds and flu. It is naturally caffeine-free.",
        overall_tea_description: "Echinacea tea is a herbal infusion derived from the echinacea plant, native to Eastern and Central North America. It has been traditionally used by Native American tribes for its medicinal properties, particularly its ability to support the immune system and help alleviate symptoms of the common cold and flu. This naturally caffeine-free tea has a mild, earthy, and slightly floral taste, often accompanied by a characteristic tingling sensation on the tongue. It is a popular choice for wellness and is consumed for its potential anti-inflammatory and antioxidant benefits."
    ),
    TeaVariety(
        tea_name: "Lemon Balm Tea",
        region_of_origin: "South-central Europe, Mediterranean, Central Asia, Iran",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Melissa, Sweet Melissa, Balm Mint",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 3),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 212), duration: ValueRange(minimum: 5, maximum: 10), steep_number: 1, steep_taste_description: "Mildly lemony, fresh, and slightly minty. Can become more herbaceous with longer steeping.")
        ],
        overall_taste_description: "Light, fresh, and distinctly lemony with subtle minty undertones. It has a smooth, calming, and slightly sweet flavor.",
        short_summary: "A soothing herbal tea made from the lemon balm plant, known for its calming properties, often used to reduce stress, anxiety, and improve sleep. It is naturally caffeine-free.",
        overall_tea_description: "Lemon Balm tea is a herbal infusion made from the leaves of the Melissa officinalis plant, native to South-central Europe, the Mediterranean, Central Asia, and Iran. It is widely recognized for its calming and soothing effects, often used to alleviate stress, anxiety, and promote restful sleep. This naturally caffeine-free tea has a light, fresh, and distinctly lemony flavor with subtle minty undertones, making it a refreshing and pleasant beverage."
    ),
    TeaVariety(
        tea_name: "Rosehip Tea",
        region_of_origin: "Europe, Asia, and Northwest Africa (widely found in temperate regions globally)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 2),
        traditional_name: "Rose Haw, Hip Berry",
        amount_of_caffiene: 1,
        main_tea_type: "Herbal",
        number_of_steeps: ValueRange(minimum: 1, maximum: 1),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 212), duration: ValueRange(minimum: 5, maximum: 10), steep_number: 1, steep_taste_description: "Tart, fruity, and slightly sweet, reminiscent of cranberry or green apple. Longer steeping can increase tartness.")
        ],
        overall_taste_description: "Bright, tart, and fruity with a subtle sweetness, often compared to cranberries or green apples. It has a refreshing and slightly tangy finish.",
        short_summary: "A vibrant herbal tea made from the fruit of the rose plant, known for its high vitamin C content and tart, fruity flavor. It is naturally caffeine-free.",
        overall_tea_description: "Rosehip tea is a herbal infusion made from the rose hips, the fruit of the rose plant, typically from Rosa canina. These hips are known for their exceptionally high vitamin C content and are widely used in traditional medicine for their immune-boosting and anti-inflammatory properties. This naturally caffeine-free tea has a bright, tart, and fruity flavor, often compared to cranberries or green apples, with a subtle sweetness. It is a refreshing beverage enjoyed both hot and cold."
    ),
    TeaVariety(
        tea_name: "Tie Guan Yin (Iron Goddess of Mercy) Oolong",
        region_of_origin: "Anxi County, Fujian Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Iron Goddess of Mercy",
        amount_of_caffiene: 3,
        main_tea_type: "Oolong",
        number_of_steeps: ValueRange(minimum: 3, maximum: 7),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 205), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Light, floral, fresh"),
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 205), duration: ValueRange(minimum: 1, maximum: 1.5), steep_number: 2, steep_taste_description: "More pronounced floral and sweet notes"),
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 205), duration: ValueRange(minimum: 1.5, maximum: 2), steep_number: 3, steep_taste_description: "Balanced, lingering aftertaste")
        ],
        overall_taste_description: "Vibrant floral aroma, golden color, buttery, velvety texture, sweet aftertaste, notes of orchid.",
        short_summary: "A highly prized Chinese oolong tea known for its distinctive floral aroma and smooth, sweet taste.",
        overall_tea_description: "Tie Guan Yin, also known as Iron Goddess of Mercy, is a premium Chinese oolong tea originating from Anxi County in Fujian Province. It is celebrated for its unique orchid-like aroma, golden-yellow liquor, and a complex flavor profile that often includes notes of butter, honey, and a lingering sweet finish. The tea leaves are typically tightly rolled into small, dark green pellets that unfurl during brewing. Depending on the processing, Tie Guan Yin can range from a greener, more floral style to a more roasted, nutty profile. It offers a moderate caffeine level and can be steeped multiple times, revealing different nuances with each infusion."
    ),
    TeaVariety(
        tea_name: "Da Hong Pao (Big Red Robe) Oolong",
        region_of_origin: "Wuyi Mountains, Fujian Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Big Red Robe",
        amount_of_caffiene: 4,
        main_tea_type: "Oolong",
        number_of_steeps: ValueRange(minimum: 5, maximum: 7),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 205, maximum: 212), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Bold, roasted, mineral notes"),
            SteepInstruction(temperature: ValueRange(minimum: 205, maximum: 212), duration: ValueRange(minimum: 1, maximum: 1.5), steep_number: 2, steep_taste_description: "More pronounced roasted and fruity notes, complex"),
            SteepInstruction(temperature: ValueRange(minimum: 205, maximum: 212), duration: ValueRange(minimum: 1.5, maximum: 2), steep_number: 3, steep_taste_description: "Sweet aftertaste, lingering warmth")
        ],
        overall_taste_description: "Rich, roasted, mineral, notes of dark honey, stone fruit, and sometimes cinnamon. Long-lasting sweet aftertaste.",
        short_summary: "A highly prized Wuyi rock oolong tea from China, known for its distinctive roasted flavor and complex aroma.",
        overall_tea_description: "Da Hong Pao, or Big Red Robe, is a legendary Wuyi rock oolong tea from the Wuyi Mountains in Fujian Province, China. It is characterized by its heavily roasted leaves, which impart a unique mineral taste, often described as 'rock rhyme' (yan yun). The flavor profile is complex, with notes of roasted nuts, dark honey, and ripe stone fruits, often accompanied by a hint of smokiness. Da Hong Pao offers a robust and full-bodied liquor with a long-lasting sweet aftertaste. It has a relatively high caffeine content for an oolong and can be steeped many times, with each infusion revealing new layers of flavor."
    ),
    TeaVariety(
        tea_name: "Dan Cong (Phoenix Oolong) Oolong",
        region_of_origin: "Fenghuang Mountains, Guangdong Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Phoenix Oolong, Single Bush",
        amount_of_caffiene: 3,
        main_tea_type: "Oolong",
        number_of_steeps: ValueRange(minimum: 5, maximum: 10),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 205, maximum: 212), duration: ValueRange(minimum: 0.1, maximum: 0.2), steep_number: 1, steep_taste_description: "Quick rinse, opening up leaves"),
            SteepInstruction(temperature: ValueRange(minimum: 205, maximum: 212), duration: ValueRange(minimum: 0.2, maximum: 0.3), steep_number: 2, steep_taste_description: "Initial burst of floral/fruity aroma, sweet"),
            SteepInstruction(temperature: ValueRange(minimum: 205, maximum: 212), duration: ValueRange(minimum: 0.3, maximum: 0.4), steep_number: 3, steep_taste_description: "Fuller body, more complex flavor, lingering aftertaste")
        ],
        overall_taste_description: "Highly aromatic with distinct floral (orchid, gardenia) or fruity (mango, peach) notes, often with a honey-like sweetness and a smooth, rich body. Specific flavors vary greatly by cultivar.",
        short_summary: "A unique category of oolong tea from Guangdong, China, known for its naturally occurring aromatic profiles resembling various fruits and flowers.",
        overall_tea_description: "Dan Cong, also known as Phoenix Oolong, is a diverse and highly prized category of oolong tea from the Fenghuang Mountains in Guangdong Province, China. The name 'Dan Cong' translates to 'single bush', referring to the traditional practice of processing leaves from individual tea bushes separately to highlight their unique characteristics. These teas are renowned for their naturally occurring aromatic profiles, which can mimic a wide range of fruits, flowers, and even spices, without any added flavorings. Common aromas include orchid, gardenia, honey, almond, and various fruit notes. Dan Cong teas offer a smooth, rich liquor with a lingering sweet aftertaste and can be steeped numerous times, evolving in flavor with each infusion. Caffeine content is moderate."
    ),
    TeaVariety(
        tea_name: "Dong Ding (Frozen Summit) Oolong",
        region_of_origin: "Lugu Township, Nantou County, Taiwan",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Frozen Summit, Icy Peak",
        amount_of_caffiene: 3,
        main_tea_type: "Oolong",
        number_of_steeps: ValueRange(minimum: 5, maximum: 8),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 190, maximum: 205), duration: ValueRange(minimum: 0.5, maximum: 0.75), steep_number: 1, steep_taste_description: "Creamy, sweet, toasted nutty flavor"),
            SteepInstruction(temperature: ValueRange(minimum: 190, maximum: 205), duration: ValueRange(minimum: 0.75, maximum: 1), steep_number: 2, steep_taste_description: "More pronounced honey and roasted notes"),
            SteepInstruction(temperature: ValueRange(minimum: 190, maximum: 205), duration: ValueRange(minimum: 1, maximum: 1.5), steep_number: 3, steep_taste_description: "Lingering sweetness, smooth finish")
        ],
        overall_taste_description: "Creamy, sweet, toasted nutty flavor with a mildly smoky, long-lasting finish. Often has honey and roasted notes.",
        short_summary: "A classic Taiwanese oolong tea known for its distinctive roasted character, creamy texture, and a sweet, nutty flavor.",
        overall_tea_description: "Dong Ding, or Frozen Summit, is one of Taiwan's most famous oolong teas, originating from the Dong Ding mountain in Nantou County. It is typically a medium-oxidized and medium-roasted oolong, which gives it a unique balance of fresh, floral notes and a warm, roasted character. The flavor profile often includes creamy, nutty, and sweet notes, with a distinctive honey-like aroma and a lingering finish. Dong Ding oolong can be steeped multiple times, with each infusion revealing new layers of its complex flavor. It has a moderate caffeine content and is a staple for oolong enthusiasts."
    ),
    TeaVariety(
        tea_name: "Jin Xuan (Milk Oolong) Oolong",
        region_of_origin: "Taiwan (various regions like Alishan, Nantou, Li Shan)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Milk Oolong, Tai Cha #12",
        amount_of_caffiene: 2,
        main_tea_type: "Oolong",
        number_of_steeps: ValueRange(minimum: 4, maximum: 6),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 185, maximum: 205), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Light, creamy, floral with milky notes"),
            SteepInstruction(temperature: ValueRange(minimum: 185, maximum: 205), duration: ValueRange(minimum: 1, maximum: 1.5), steep_number: 2, steep_taste_description: "More pronounced milky and sweet notes"),
            SteepInstruction(temperature: ValueRange(minimum: 185, maximum: 205), duration: ValueRange(minimum: 1.5, maximum: 2), steep_number: 3, steep_taste_description: "Smooth, buttery, lingering sweetness")
        ],
        overall_taste_description: "Known for its natural milky, creamy, and buttery notes, often accompanied by a light floral aroma and a sweet, smooth finish.",
        short_summary: "A popular Taiwanese oolong tea famous for its naturally occurring milky and creamy aroma and taste.",
        overall_tea_description: "Jin Xuan, commonly known as Milk Oolong, is a distinctive Taiwanese oolong tea cultivar (Taiwan Tea #12) celebrated for its naturally occurring creamy, buttery, and sometimes milky aroma and flavor. This unique characteristic is inherent to the tea plant itself and is not due to any added flavorings. It typically has a light oxidation and can be grown in various regions across Taiwan, including Alishan and Nantou. Jin Xuan tea offers a smooth, mellow liquor with a light floral undertone and a sweet, lingering aftertaste. It has a relatively low to moderate caffeine content and can be steeped multiple times, making it a delightful and approachable oolong for many tea drinkers."
    ),
    TeaVariety(
        tea_name: "Oriental Beauty (Dong Fang Mei Ren) Oolong",
        region_of_origin: "Hsinchu County, Taiwan",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Dong Fang Mei Ren, Bai Hao Oolong, Champagne Oolong",
        amount_of_caffiene: 3,
        main_tea_type: "Oolong",
        number_of_steeps: ValueRange(minimum: 4, maximum: 6),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 195), duration: ValueRange(minimum: 1, maximum: 1.5), steep_number: 1, steep_taste_description: "Sweet, fruity, honey-like with floral notes"),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 195), duration: ValueRange(minimum: 1.5, maximum: 2), steep_number: 2, steep_taste_description: "More pronounced honey and ripe fruit flavors"),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 195), duration: ValueRange(minimum: 2, maximum: 2.5), steep_number: 3, steep_taste_description: "Complex, lingering sweetness, muscatel notes")
        ],
        overall_taste_description: "Sweet, fruity, and honey-like, with distinct notes of ripe fruit (peach, lychee) and floral undertones. Often described as having a natural muscatel flavor.",
        short_summary: "A highly oxidized Taiwanese oolong tea, famous for its natural honey and fruity notes, resulting from insect bites on the tea leaves.",
        overall_tea_description: "Oriental Beauty, also known as Dong Fang Mei Ren, is a unique and highly prized Taiwanese oolong tea. It is distinguished by its heavy oxidation and the fact that its leaves are bitten by a small insect called the tea green leafhopper (Jacobiasca formosana) during growth. This interaction causes the tea plant to produce defensive compounds that contribute to the tea's characteristic sweet, honey-like, and fruity flavor profile, often with notes of ripe peach, lychee, and a natural muscatel aroma. The tea has a beautiful amber liquor and a moderate caffeine content. It can be steeped multiple times, offering a complex and evolving taste experience."
    ),
    TeaVariety(
        tea_name: "High-Mountain Oolongs (Gao Shan Cha) Oolong",
        region_of_origin: "Central Taiwan (various high-altitude regions like Alishan, Lishan, Shanlinxi)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Gao Shan Cha",
        amount_of_caffiene: 3,
        main_tea_type: "Oolong",
        number_of_steeps: ValueRange(minimum: 6, maximum: 10),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 205), duration: ValueRange(minimum: 0.5, maximum: 0.75), steep_number: 1, steep_taste_description: "Fresh, floral, sweet, often with a creamy mouthfeel"),
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 205), duration: ValueRange(minimum: 0.75, maximum: 1), steep_number: 2, steep_taste_description: "More intense floral and fruity notes, complex sweetness"),
            SteepInstruction(temperature: ValueRange(minimum: 195, maximum: 205), duration: ValueRange(minimum: 1, maximum: 1.5), steep_number: 3, steep_taste_description: "Lingering aftertaste, smooth, often with a hint of 'mountain air' freshness")
        ],
        overall_taste_description: "Fresh, clean, and floral, often with sweet, creamy, and sometimes fruity notes. Known for a smooth mouthfeel and a distinct 'mountain air' freshness.",
        short_summary: "A category of Taiwanese oolong teas grown at high altitudes, prized for their fresh, floral, and often creamy flavor profiles.",
        overall_tea_description: "High-Mountain Oolongs, or Gao Shan Cha, refer to a prestigious category of Taiwanese oolong teas cultivated at elevations typically above 1,000 meters. The unique climatic conditions at these altitudes—including cooler temperatures, mist, and rich soil—contribute to the tea's distinctive characteristics. These teas are generally lightly oxidized and unroasted, resulting in a fresh, clean, and vibrant flavor profile. Common aromas include floral (orchid, gardenia), sweet, and often a creamy or buttery mouthfeel. Gao Shan Cha is highly valued for its smooth texture, complex aroma, and long-lasting, refreshing aftertaste. While caffeine content is moderate, the overall experience is often described as uplifting and calming. Popular regions for Gao Shan Cha include Alishan, Lishan, and Shanlinxi."
    ),
    TeaVariety(
        tea_name: "Jun Shan Yin Zhen (Yellow Tea)",
        region_of_origin: "Junshan Island, Hunan Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Junshan Silver Needle",
        amount_of_caffiene: 2,
        main_tea_type: "Yellow",
        number_of_steeps: ValueRange(minimum: 3, maximum: 4),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 175), duration: ValueRange(minimum: 2, maximum: 3), steep_number: 1, steep_taste_description: "Light, sweet, with notes of melon, muscatel, and sugarcane."),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 175), duration: ValueRange(minimum: 2, maximum: 3), steep_number: 2, steep_taste_description: "Deeper yellow, more savory, herbal notes become more prominent."),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 175), duration: ValueRange(minimum: 3, maximum: 4), steep_number: 3, steep_taste_description: "Full-bodied, slightly spicy with a lasting sweetness.")
        ],
        overall_taste_description: "Sweet, nutty undertones, with notes of melon, muscatel, sugarcane, and a comforting, stimulating character.",
        short_summary: "Jun Shan Yin Zhen is a rare and highly prized yellow tea from Hunan, China, known for its delicate flavor and unique processing.",
        overall_tea_description: "Jun Shan Yin Zhen, also known as Junshan Silver Needle, is considered one of China's rarest teas. It is produced on Junshan Island in Hunan Province and is characterized by its beautiful sage downy green and silvery buds. The tea has a sweet and nutty taste with notes of melon, muscatel, and sugarcane. It is lightly oxidized, resulting in a mellow flavor without the astringency of green tea. It can be steeped multiple times, with each steep revealing different nuances of its complex flavor profile."
    ),
    TeaVariety(
        tea_name: "Meng Ding Huang Ya (Yellow Tea)",
        region_of_origin: "Mount Meng, Sichuan Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Meng Ding Yellow Buds",
        amount_of_caffiene: 2,
        main_tea_type: "Yellow",
        number_of_steeps: ValueRange(minimum: 3, maximum: 5),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 1, steep_taste_description: "Light, sweet, with hazelnut, vanilla, and herbal notes."),
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 0.5, maximum: 1), steep_number: 2, steep_taste_description: "Creamy texture, with hints of green apple and melon."),
            SteepInstruction(temperature: ValueRange(minimum: 160, maximum: 175), duration: ValueRange(minimum: 0.75, maximum: 1.5), steep_number: 3, steep_taste_description: "Nutty and sweet, with a mild flavor and smooth finish.")
        ],
        overall_taste_description: "Sweet, nutty, with hints of vanilla, green apple, melon, and a creamy texture. Mellow and refreshing.",
        short_summary: "Meng Ding Huang Ya is a rare yellow tea from Sichuan, China, known for its sweet and nutty flavor profile.",
        overall_tea_description: "Meng Ding Huang Ya, also known as Meng Ding Yellow Buds, is a highly regarded yellow tea from Mount Meng in Sichuan Province, China. It is characterized by its long, straight leaf buds and light yellow liquor. The tea offers a delicate sweetness with notes of hazelnut, vanilla, and herbs, often complemented by hints of green apple and melon. Its processing involves a unique 'men huang' step that removes the grassy notes typically found in green teas, resulting in a smooth, mellow, and refreshing cup. It can be steeped multiple times, revealing a complex and evolving flavor."
    ),
    TeaVariety(
        tea_name: "Mo Gan Huang Ya",
        region_of_origin: "Moganshan, Zhejiang Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Mo Gan Yellow Buds",
        amount_of_caffiene: 2,
        main_tea_type: "Yellow",
        number_of_steeps: ValueRange(minimum: 3, maximum: 5),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 2, maximum: 3), steep_number: 1, steep_taste_description: "Smooth, creamy nuttiness, with hints of wildflower and honey."),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 3, maximum: 4), steep_number: 2, steep_taste_description: "Thick broth-like infusion, with umami sweetness and a slight tingle."),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 4, maximum: 5), steep_number: 3, steep_taste_description: "Lingering umami sweetness, with a clean, strong finish.")
        ],
        overall_taste_description: "Nutty, umami, with a thick mouthfeel, wildflower aroma, and a honeyed, lingering sweetness.",
        short_summary: "Mo Gan Huang Ya is a rare yellow tea from Zhejiang, China, known for its nutty, umami, and honeyed flavor.",
        overall_tea_description: "Mo Gan Huang Ya, also known as Mo Gan Yellow Buds, is a rare yellow tea produced in Moganshan, Zhejiang Province, China. It is made using complex yellow tea processing techniques, resulting in a unique flavor profile. The tea offers a smooth, creamy nuttiness, almost like sweetened peanut butter, with hints of wildflower and honey. It has a thick, broth-like infusion with an umami sweetness and a slight tingle on the tongue. This tea is known for its gentle yet deep flavor and naturally sweet taste due to its high amino acid content, with virtually no bitterness or grassy notes."
    ),
    TeaVariety(
        tea_name: "Huo Shan Huang Ya (Yellow Tea)",
        region_of_origin: "Huo Shan, Anhui Province, China",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Huo Shan Yellow Buds",
        amount_of_caffiene: 2,
        main_tea_type: "Yellow",
        number_of_steeps: ValueRange(minimum: 3, maximum: 5),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 185), duration: ValueRange(minimum: 1.5, maximum: 2), steep_number: 1, steep_taste_description: "Sweet and nutty, with hints of chestnut and almond blossoms."),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 185), duration: ValueRange(minimum: 1.5, maximum: 2.5), steep_number: 2, steep_taste_description: "Creamy, with vegetal and fruity notes, and a slight umami."),
            SteepInstruction(temperature: ValueRange(minimum: 175, maximum: 185), duration: ValueRange(minimum: 2, maximum: 3), steep_number: 3, steep_taste_description: "Mellow, with a lasting sweetness and a clean finish.")
        ],
        overall_taste_description: "Sweet, nutty, with prominent chestnut flavor, hints of almond blossoms, vegetal and fruity notes, and a creamy texture.",
        short_summary: "Huo Shan Huang Ya is a yellow tea from Anhui, China, known for its distinct chestnut flavor and mellow taste.",
        overall_tea_description: "Huo Shan Huang Ya, also known as Huo Shan Yellow Buds, is a delicate and sweet yellow tea from Anhui Province, China. It is characterized by its sweet and nutty taste, often with a strong chestnut flavor. It also presents hints of almond blossoms, vegetal, and fruity notes, with a creamy mouthfeel. The tea is lightly oxidized, making it less tannic and sweeter than many green teas, while still retaining a fresh profile. It is considered one of the more accessible yellow teas and can be steeped multiple times."
    ),
    TeaVariety(
        tea_name: "Huang Ya Cha (Yellow)",
        region_of_origin: "Various regions in China (general category)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1),
        traditional_name: "Yellow Bud Tea",
        amount_of_caffiene: 2,
        main_tea_type: "Yellow",
        number_of_steeps: ValueRange(minimum: 2, maximum: 4),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 1, steep_taste_description: "Pure and refreshing, with a delicate sweetness and mild floral notes."),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 1.5, maximum: 2.5), steep_number: 2, steep_taste_description: "Mellow and smooth, with a balanced flavor and minimal astringency.")
        ],
        overall_taste_description: "Generally pure and refreshing, with delicate sweetness, mild floral notes, and a smooth, mellow character.",
        short_summary: "Huang Ya Cha is a general category of yellow tea characterized by its use of tender tea buds, offering a pure and refreshing taste.",
        overall_tea_description: "Huang Ya Cha, meaning Yellow Bud Tea, is a classification of yellow tea based on the picking standard, primarily consisting of tender tea buds. It is known for its pure and refreshing taste, often described as having a delicate sweetness and mild floral notes. Unlike green teas, Huang Ya Cha undergoes an additional 'men huang' process, which removes the grassy notes and results in a smoother, mellower flavor with minimal astringency. Specific characteristics can vary depending on the region of origin and processing methods, but generally, these teas offer a clean and balanced cup."
    ),
    TeaVariety(
        tea_name: "Huang Xiao Cha (Yellow)",
        region_of_origin: "Various regions in China (general category)",
        tsp_per_8_oz: ValueRange(minimum: 1, maximum: 1.5),
        traditional_name: "Small Yellow Tea",
        amount_of_caffiene: 2,
        main_tea_type: "Yellow",
        number_of_steeps: ValueRange(minimum: 2, maximum: 4),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 1, maximum: 2), steep_number: 1, steep_taste_description: "Mellow and sweet, with floral notes and a smooth body."),
            SteepInstruction(temperature: ValueRange(minimum: 170, maximum: 185), duration: ValueRange(minimum: 1.5, maximum: 2.5), steep_number: 2, steep_taste_description: "Fruity-sweet, with a comforting and relaxing character.")
        ],
        overall_taste_description: "Mellow and sweet, with floral and fruity-sweet notes, a smooth body, and a comforting character.",
        short_summary: "Huang Xiao Cha is a general category of yellow tea made from smaller, younger leaves, offering a mellow and sweet flavor.",
        overall_tea_description: "Huang Xiao Cha, meaning Small Yellow Tea, refers to yellow teas made from smaller, younger leaves, often including one bud and one to two leaves. These teas are known for their mellow and sweet flavor profile, often with floral notes. They undergo a similar 'men huang' process to other yellow teas, which contributes to their smooth taste and lack of bitterness or grassiness. Specific flavor characteristics can vary depending on the region and processing, but generally, Huang Xiao Cha offers a delicate and comforting tea experience."
    ),
    TeaVariety(
        tea_name: "Huang Da Cha (Yellow)",
        region_of_origin: "Various regions in China (general category, often associated with Huo Shan)",
        tsp_per_8_oz: ValueRange(minimum: 1.5, maximum: 2),
        traditional_name: "Big Yellow Tea",
        amount_of_caffiene: 3,
        main_tea_type: "Yellow",
        number_of_steeps: ValueRange(minimum: 2, maximum: 4),
        steep_instructions: [
            SteepInstruction(temperature: ValueRange(minimum: 185, maximum: 195), duration: ValueRange(minimum: 2, maximum: 3), steep_number: 1, steep_taste_description: "Bold and toasty, with notes of roasted grains, chocolate, and a prominent nutty flavor."),
            SteepInstruction(temperature: ValueRange(minimum: 185, maximum: 195), duration: ValueRange(minimum: 2.5, maximum: 3.5), steep_number: 2, steep_taste_description: "Rich and thick, with a lingering sweetness and hints of cereal and malt.")
        ],
        overall_taste_description: "Bold, toasty, and rich, with notes of roasted grains, chocolate, cereal, malt, and a prominent nutty flavor. Naturally sweet with a full-bodied character.",
        short_summary: "Huang Da Cha is a category of yellow tea made from larger, more mature leaves, known for its bold, roasted, and nutty flavor profile.",
        overall_tea_description: "Huang Da Cha, meaning Big Yellow Tea, refers to yellow teas made from larger, more mature leaves, often including stalks. It is known as the 'coffee of tea' due to its heavily roasted processing, which imparts a bold, toasty, and rich flavor. This tea often features notes of roasted grains, chocolate, cereal, and malt, with a prominent nutty taste. The inclusion of stalks contributes to its natural sweetness. Huang Da Cha offers a full-bodied character similar to green tea but without the typical grassy notes, making it a unique and comforting tea experience."
    )
]
