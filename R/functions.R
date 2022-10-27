:w

:w
# --- FUNCTIONS --- #
# ----------------- #

# radian restart ----

radian_restart <- function(args = NULL) {
  getOption("rchitect.py_tools")$attach()
  os <- import("os") # nolint
  sys <- import("sys") # nolint
  os$execv(sys$executable, c("sys$executable", "-m", "radian", args))
}

# creating parameters pof json ----

pof_json <- function(args = NULL) {
  if (fs::file_exists("data/aux_files/pof.json")) {
    pof_list <- list(
      morador = list(
        file_name = "MORADOR",
        widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 1, 2, 2, 4, 3, 1, 1, 1, 1, 1, 2, 1,
          2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1,
          1, 2, 1, 1, 1, 2, 1, 2, 14, 14, 10, 1, 1, 20, 20, 20, 20
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "V0306", "V0401", "V04021", "V04022",
          "V04023", "V0403", "V0404", "V0405", "V0406", "V0407", "V0408",
          "V0409", "V0410", "V0411", "V0412", "V0413", "V0414", "V0415",
          "V0416", "V041711", "V041712", "V041721", "V041722", "V041731",
          "V041732", "V041741", "V041742", "V0418", "V0419", "V0420",
          "V0421", "V0422", "V0423", "V0424", "V0425", "V0426", "V0427",
          "V0428", "V0429", "V0430", "ANOS_ESTUDO", "PESO", "PESO_FINAL",
          "RENDA_TOTAL", "INSTRUCAO", "COMPOSICAO", "PC_RENDA_DISP",
          "PC_RENDA_MONET", "PC_RENDA_NAO_MONET", "PC_DEDUCAO"
        )
      ),
      despesa_coletiva = list(
        file_name = "DESPESA_COLETIVA",
        widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 7, 2, 4, 10, 2, 2, 1, 10, 1, 12, 10,
          10, 1, 1, 2, 14, 14, 10, 5
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "QUADRO", "SEQ", "V9001", "V9002", "V9005", "V8000",
          "V9010", "V9011", "V9012", "V1904", "V1905", "DEFLATOR",
          "V8000_DEFLA", "V1904_DEFLA", "COD_IMPUT_VALOR",
          "COD_IMPUT_QUANTIDADE", "FATOR_ANUALIZACAO", "PESO",
          "PESO_FINAL", "RENDA_TOTAL", "V9004"
        )
      ),
      caderneta_coletiva = list(
        file_name = "CADERNETA_COLETIVA", widths = c(
          2, 4, 1, 9, 2, 1, 2, 7, 2, 10, 2, 2, 12, 10, 1, 2, 14, 14,
          10
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "QUADRO", "V9001", "V9002", "V8000", "V9010", "V9011",
          "DEFLATOR", "V8000_DEFLA", "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
          "PESO", "PESO_FINAL", "RENDA_TOTAL"
        )
      ),
      despesa_individual = list(
        file_name = "DESPESA_INDIVIDUAL", widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 2, 7, 2, 10, 2, 2, 1, 1, 1, 12, 10,
          1, 2, 14, 14, 10, 5
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "QUADRO", "SEQ", "V9001", "V9002",
          "V8000", "V9010", "V9011", "V9012", "V4104", "V4105", "DEFLATOR",
          "V8000_DEFLA", "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO", "PESO",
          "PESO_FINAL", "RENDA_TOTAL", "V9004"
        )
      ),
      aluguel_estimado = list(
        file_name = "ALUGUEL_ESTIMADO", widths = c(
          2, 4, 1, 9, 2, 1, 2, 7, 2, 10, 2, 2, 12, 10, 1, 2, 14, 14,
          10
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "QUADRO", "V9001", "V9002", "V8000", "V9010", "V9011",
          "DEFLATOR", "V8000_DEFLA", "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
          "PESO", "PESO_FINAL", "RENDA_TOTAL"
        )
      ),
      rendimento_trabalho = list(
        file_name = "RENDIMENTO_TRABALHO", widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 1, 1, 7, 1, 1, 1, 1, 1, 1, 7, 7, 7,
          7, 2, 2, 3, 1, 12, 10, 10, 10, 10, 1, 1, 14, 14, 10, 4, 5
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "QUADRO", "SUB_QUADRO", "SEQ",
          "V9001", "V5302", "V53021", "V5303", "V5304", "V5305", "V5307",
          "V8500", "V531112", "V531122", "V531132", "V9010", "V9011",
          "V5314", "V5315", "DEFLATOR", "V8500_DEFLA", "V531112_DEFLA",
          "V531122_DEFLA", "V531132_DEFLA", "COD_IMPUT_VALOR",
          "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL", "RENDA_TOTAL",
          "V53011", "V53061"
        )
      ),
      outros_rendimentos = list(
        file_name = "OUTROS_RENDIMENTOS", widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 2, 7, 10, 10, 2, 2, 12, 10, 10, 1,
          1, 14, 14, 10
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "QUADRO", "SEQ", "V9001", "V8500",
          "V8501", "V9010", "V9011", "DEFLATOR", "V8500_DEFLA", "V8501_DEFLA",
          "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
          "RENDA_TOTAL"
        )
      ),
      domicilio = list(
        file_name = "DOMICILIO", widths = c(
          2, 4, 1, 9, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
          1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 14, 14, 1
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "V0201", "V0202", "V0203", "V0204", "V0205", "V0206", "V0207",
          "V0208", "V0209", "V02101", "V02102", "V02103", "V02104", "V02105",
          "V02111", "V02112", "V02113", "V0212", "V0213", "V02141", "V02142",
          "V0215", "V02161", "V02162", "V02163", "V02164", "V0217", "V0219",
          "V0220", "V0221", "PESO", "PESO_FINAL", "V6199"
        )
      ),
      inventario = list(
        file_name = "INVENTARIO",
        widths = c(2, 4, 1, 9, 2, 1, 2, 2, 7, 2, 2, 4, 1, 14, 14, 10),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "QUADRO", "SEQ", "V9001", "V9005", "V9002", "V1404",
          "V9012", "PESO", "PESO_FINAL", "RENDA_TOTAL"
        )
      ),
      caracteristicas_dieta = list(
        file_name = "CARACTERISTICAS_DIETA", widths = c(
          2, 4, 1, 9, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
          1, 1, 1, 1, 1, 1, 3, 3, 14, 15, 10
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "V7101", "V7102", "V71031", "V71032",
          "V71033", "V71034", "V71035", "V71036", "V71037", "V71038",
          "V7104", "V71051", "V71052", "V71053", "V71054", "V71055",
          "V71056", "V71A01", "V71A02", "V72C01", "V72C02", "PESO",
          "PESO_FINAL", "RENDA_TOTAL"
        )
      ),
      consumo_alimentar = list(
        file_name = "CONSUMO_ALIMENTAR", widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 2, 4, 2, 7, 3, 2, 1, 1, 1, 1, 1, 1,
          1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 7, 9, 6, 14, 14, 14, 14, 14,
          14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
          14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 10, 15, 1
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFOR,MANTE", "QUADRO", "SEQ", "V9005", "V9007",
          "V9001", "V9015", "V9016", "V9017", "V9018", "V9019", "V9020",
          "V9021", "V9022", "V9023", "V9024", "V9025", "V9026", "V9027",
          "V9028", "V9029", "V9030", "COD_UNIDADE_MEDIDA_FINAL",
          "COD_PREPARACAO_FINAL", "GRAMATURA1", "QTD", "COD_TBCA",
          "ENERGIA_KCAL", "ENERGIA_KJ", "PTN", "CHOTOT", "FIBRA", "LIP",
          "COLEST", "AGSAT", "AGMONO", "AGPOLI", "AGTRANS", "CALCIO",
          "FERRO", "SODIO", "MAGNESIO", "FOSFORO", "POTASSIO", "COBRE",
          "ZINCO", "VITA_RAE", "TIAMINA", "RIBOFLAVINA", "NIACINA",
          "PIRIDOXAMINA", "COBALAMINA", "VITD", "VITE", "VITC", "FOLATO",
          "PESO", "PESO_FINAL", "RENDA_TOTAL", "DIA_SEMANA", "DIA_ATIPICO"
        )
      ),
      condicoes_vida = list(
        file_name = "CONDICOES_VIDA", widths = c(
          2, 4, 1, 9, 2, 1, 2, 1, 6, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
          1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
          1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 14, 14, 10
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "V6101", "V6102", "V6103", "V61041",
          "V61042", "V61043", "V61044", "V61045", "V61046", "V61051",
          "V61052", "V61053", "V61054", "V61055", "V61056", "V61057",
          "V61058", "V6106", "V61062", "V61063", "V61064", "V61065",
          "V61066", "V61067", "V61068", "V61069", "V610610", "V610611",
          "V61071", "V6107:w2", "V61073", "V6108", "V6109", "V6110", "V6111",
          "V6112", "V6113", "V6114", "V6115", "V6116", "V6117", "V6118",
          "V6119", "V6120", "V6121", "PESO", "PESO_FINAL", "RENDA_TOTAL"
        )
      ),
      restricao_produtos_servicos_saude = list(
        file_name = "RESTRICAO_PRODUTOS_SERVICOS_SAUDE",
        widths = c(2, 4, 1, 9, 2, 1, 2, 2, 2, 7, 1, 14, 14, 10),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "QUADRO", "SEQ", "V9001", "V9013",
          "PESO", "PESO_FINAL", "RENDA_TOTAL"
        )
      ),
      servico_nao_monetario_pof2 = list(
        file_name = "SERVICO_NAO_MONETARIO_POF2", widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 7, 2, 10, 2, 2, 10, 1, 12, 10, 10,
          1, 2, 14, 14, 10, 5
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "QUADRO", "SEQ", "V9001", "V9002", "V8000", "V9010",
          "V9011", "V1904", "V1905", "DEFLATOR", "V8000_DEFLA", "V1904_DEFLA",
          "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
          "RENDA_TOTAL", "V9004"
        )
      ),
      servico_nao_monetario_pof4 = list(
        file_name = "SERVICO_NAO_MONETARIO_POF4",
        widths = c(
          2, 4, 1, 9, 2, 1, 2, 2, 2, 7, 2, 10, 2, 2, 1, 1, 12, 10, 1,
          2, 14, 14, 10, 5
        ),
        col_names = c(
          "UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM",
          "NUM_UC", "COD_INFORMANTE", "QUADRO", "SEQ", "V9001", "V9002",
          "V8000", "V9010", "V9011", "V4104", "V4105", "DEFLATOR",
          "V8000_DEFLA", "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
          "PESO", "PESO_FINAL", "RENDA_TOTAL", "V9004"
        )
      )
    )

    pof_json <- rjson::toJSON(pof_list, pretty = TRUE)

    write(x = pof_json, file = "data/aux_files/pof.json")
  }
}

# download pof data in .parquet files ----

pof_download <- function(args = NULL) {

  data_url <- "https://ftp.ibge.gov.br/Orcamentos_Familiares/Pesquisa_de_Orcamentos_Familiares_2017_2018/Microdados/Dados_20210304.zip" # nolint

  tmp_dir <- fs::dir_create(glue::glue("{tempdir()}/pof"))

  tmp_file <- tempfile()

  pof_json <- "data/aux_files/pof.json"

  if (!fs::file_exists(pof_json)) pof_json()

  pof_parameters <- rjson::fromJSON(file = pof_json)

  curl::curl_download(
    url = data_url,
    destfile = tmp_file
  )

  zip::unzip(
    zipfile = tmp_file,
    exdir = tmp_dir
  )

  purrr::map(
    pof_parameters,
    function(i) {
      df <- readr::read_fwf(
        file = glue::glue("{tmp_dir}/{i$file_name}.txt"),
        col_positions = readr::fwf_widths(i$widths),
        show_col_types = FALSE
      )

      names(df) <- janitor::make_clean_names(i$col_names)

      file_name <- janitor::make_clean_names(i$file_name)

      df |>
        janitor::remove_empty(which = c("rows", "cols")) |>
        arrow::write_parquet(glue::glue("data/{file_name}.parquet"))
    }
  )
}
