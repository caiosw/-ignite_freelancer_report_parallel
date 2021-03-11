defmodule FreelancerReportTest do
  use ExUnit.Case

  describe "build/1" do
    test "if file exists, return report" do
      filename = "gen_report_test.csv"

      response = FreelancerReport.build(filename)

      expected_response = %{
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

      assert response == expected_response
    end

    test "if file don't exists, return an error" do
      filename = "potato.csv"

      response = FreelancerReport.build(filename)

      expected_response = {:error, "File not found!"}

      assert response == expected_response
    end
  end

  describe "build_from_list/1" do
    test "read list of files asynchronously and merge then into a single report" do
      files = ["gen_report_test.csv", "gen_report_test.csv"]

      response = FreelancerReport.build_from_list(files)

      expected_response = %{
        all_hours: %{
          "Cleiton" => 8,
          "Daniele" => 42,
          "Danilo" => 12,
          "Diego" => 14,
          "Giuliano" => 20,
          "Jakeliny" => 28,
          "Joseph" => 6,
          "Mayk" => 38
        },
        hours_per_month: %{
          "Cleiton" => %{"junho" => 8},
          "Daniele" => %{"abril" => 14, "dezembro" => 10, "junho" => 2, "maio" => 16},
          "Danilo" => %{"fevereiro" => 12},
          "Diego" => %{"agosto" => 8, "setembro" => 6},
          "Giuliano" => %{"abril" => 2, "fevereiro" => 18},
          "Jakeliny" => %{"julho" => 16, "março" => 12},
          "Joseph" => %{"março" => 6},
          "Mayk" => %{"dezembro" => 10, "julho" => 14, "setembro" => 14}
        },
        hours_per_year: %{
          "Cleiton" => %{"2016" => 6, "2020" => 2},
          "Daniele" => %{"2016" => 20, "2017" => 6, "2018" => 14, "2020" => 2},
          "Danilo" => %{"2019" => 12},
          "Diego" => %{"2016" => 6, "2017" => 8},
          "Giuliano" => %{"2017" => 6, "2019" => 12, "2020" => 2},
          "Jakeliny" => %{"2017" => 16, "2019" => 12},
          "Joseph" => %{"2017" => 6},
          "Mayk" => %{"2016" => 14, "2017" => 16, "2019" => 8}
        }
      }

      assert response == expected_response
    end
  end
end
