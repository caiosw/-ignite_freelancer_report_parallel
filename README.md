# FreelancerReport

This is an Elixir project from Rocketseat's Ignite course (Chapter 1, module 2)

The project's goal is to create a Map report from a CSV file, aggregating the results as bellow:

Input file format: 
Daniele,7,29,4,2018
Mayk,4,9,12,2019
Daniele,5,27,12,2016
Mayk,1,2,12,2017
Giuliano,3,13,2,2017
Cleiton,1,22,6,2020
Giuliano,6,18,2,2019
Jakeliny,8,18,7,2017
Joseph,3,17,3,2017
Jakeliny,6,23,3,2019
Cleiton,3,20,6,2016
Daniele,5,1,5,2016
Giuliano,1,2,4,2020
Daniele,3,5,5,2017
Daniele,1,26,6,2020
Diego,3,11,9,2016
Mayk,7,28,7,2017
Mayk,7,3,9,2016
Danilo,6,28,2,2019
Diego,4,15,8,2017 

Expected output:

  %{
   all_hours: %{
     "Cleiton" => 4,
     "Daniele" => 21,
     "Danilo" => 6,
     "Diego" => 7,
     "Giuliano" => 10,
     "Jakeliny" => 14,
     "Joseph" => 3,
     "Mayk" => 19
   },
   hours_per_month: %{
     "Cleiton" => %{"junho" => 4},
     "Daniele" => %{"abril" => 7, "dezembro" => 5, "junho" => 1, "maio" => 8},
     "Danilo" => %{"fevereiro" => 6},
     "Diego" => %{"agosto" => 4, "setembro" => 3},
     "Giuliano" => %{"abril" => 1, "fevereiro" => 9},
     "Jakeliny" => %{"julho" => 8, "março" => 6},
     "Joseph" => %{"março" => 3},
     "Mayk" => %{"dezembro" => 5, "julho" => 7, "setembro" => 7}
   },
   hours_per_year: %{
     "Cleiton" => %{"2016" => 3, "2020" => 1},
     "Daniele" => %{"2016" => 10, "2017" => 3, "2018" => 7, "2020" => 1},
     "Danilo" => %{"2019" => 6},
     "Diego" => %{"2016" => 3, "2017" => 4},
     "Giuliano" => %{"2017" => 3, "2019" => 6, "2020" => 1},
     "Jakeliny" => %{"2017" => 8, "2019" => 6},
     "Joseph" => %{"2017" => 3},
     "Mayk" => %{"2016" => 7, "2017" => 8, "2019" => 4}
   }
  }
