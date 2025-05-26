# Instalar paquetes si no los tienes
install.packages(c("tidyverse", "plm"))

# Cargar librerías
library(tidyverse)
library(plm)

install.packages(c("readxl", "dplyr", "plm"))
library(readxl)
library(dplyr)
library(plm)
library(tidyr)

# Ruta donde están los archivos
archivo <- "C:/Users/mercy/OneDrive/Escritorio/Maestria/Herramientas Informaticas/"

# Leer y transformar base1
b1 <- read_excel(paste0(archivo, "at_least_basic_sanitation_overall_access_percent.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "saneamiento") %>%
  rename(pais = country)

# Leer y transformar base2
b2 <- read_excel(paste0(archivo, "at_least_basic_water_source_overall_access_percent.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "a_agua") %>%
  rename(pais = country)

# Leer y transformar base3
b3 <- read_excel(paste0(archivo, "child_mortality_0_5_year_olds_dying_per_1000_born.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "mortalidad") %>%
  rename(pais = country)

# Leer y transformar base4
b4 <- read_excel(paste0(archivo, "children_per_woman_total_fertility.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "fertilidad") %>%
  rename(pais = country)

# Leer y transformar base5
b5 <- read_excel(paste0(archivo, "gdp_pcap_limpio.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "pib_pc") %>%
  rename(pais = country)

# Leer y transformar base7
b6 <- read_excel(paste0(archivo, "government_health_spending_per_person_us.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "gasto_g") %>%
  rename(pais = country)

# Leer y transformar base8
b7 <- read_excel(paste0(archivo, "total_health_spending_per_person_us.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "gasto_s") %>%
  rename(pais = country)

# Leer y transformar base9
b8 <- read_excel(paste0(archivo, "urban_population_percent_of_total.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "urbano") %>%
  rename(pais = country)

# Leer y transformar base10
b9 <- read_excel(paste0(archivo, "vacc_rate.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "vacuna") %>%
  rename(pais = country)

# Leer y transformar base10
b10 <- read_excel(paste0(archivo, "lex.xlsx")) %>%
  pivot_longer(cols = -country, names_to = "año", values_to = "expectativa") %>%
  rename(pais = country)

# Unir bases paso a paso
base_union <- b1 %>%
  left_join(b2, by = c("pais", "año")) %>%
  left_join(b3, by = c("pais", "año")) %>%
  left_join(b4, by = c("pais", "año")) %>%
  left_join(b5, by = c("pais", "año")) %>%
  left_join(b6, by = c("pais", "año")) %>%
  left_join(b7, by = c("pais", "año")) %>%
  left_join(b8, by = c("pais", "año")) %>%
  left_join(b9, by = c("pais", "año")) %>%
  left_join(b10, by = c("pais", "año")) %>%
  
  mutate(año = as.integer(año))  # importante: convertir año a número
View(base_union)

base_filtrado <- base_union %>%
  filter(año >= 2000 & año <= 2022,
         pais %in% c("Chile", "Argentina", "Peru", "Bolivia", "Brasil", "Colombia", "Ecuador", "Guyana", "Paraguay", "Surinam", "Uruguay", "Venezuela"))
View(base_filtrado)