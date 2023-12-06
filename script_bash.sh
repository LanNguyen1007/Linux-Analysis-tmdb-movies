#Là Shebang (tệp này là script được viết bằng bash)
#!/bin/bash

#Remove all file làm task trước đó để khi chạy script_bash.sh thì không bị file trùng lập
find resource/*.csv -type f -delete 

#Download file gốc từ URL:
curl -O https://raw.githubusercontent.com/yinghaoz1/tmdb-movie-dataset-analysis/master/tmdb-movies.csv

#Task 1: Sắp xếp các bộ film theo ngày phát hành giảm dần rồi lưu file mới
csvsort -c release_date -r tmdb-movies.csv > sorted_movies_task1.csv

#Task 2: Lọc ra các bộ film có đánh giá trung bình trên 7.5 rồi lưu file mới
csvsql --query "SELECT * FROM 'tmdb-movies' WHERE vote_average > 7.5" tmdb-movies.csv > high_rated_movies.csv 

#Task3: Tìm ra film có doanh thu cao nhất và doanh thu thấp nhất
csvsort -c revenue -r tmdb-movies.csv | { head -n 2; tail -n 1; } > highest_lowest_revenue_movies_task3.csv

#Task4: Tính tổng doanh thu tất cả các bộ film
csvsql --query "SELECT SUM(revenue) FROM 'tmdb-movies'" tmdb-movies.csv > Total_revenue_task4.csv

#Task5: Tìm ra top 10 film đem về lợi nhuận cao nhất
csvsql --query "SELECT * FROM 'tmdb-movies' ORDER BY revenue_adj DESC LIMIT 10" tmdb-movies.csv > top10_high_revenue_task5.csv

#Task6: Đạo diễn nào có nhiều bộ film nhất
csvsql --query "SELECT director, COUNT(*) AS film_count FROM 'tmdb-movies' GROUP BY director ORDER BY film_count DESC LIMIT 1" tmdb-movies.csv > Total_director_task6.csv

#Task7: Thống kê số lượng film theo thể loại
csvsql --query "SELECT genres, COUNT(*) AS movie_count FROM 'tmdb-movies' GROUP BY genres ORDER BY movie_count DESC" tmdb-movies.csv | csvlook > movie_count_by_genres_task7.csv

#Thông báo script đã chạy thành công 
echo "Script run completed." 


