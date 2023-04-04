--Select * 
--from PortfolioProject..CovidDeaths
--order by 3,4

-- Select data that we are going to be using
Select location, date, total_cases, new_cases, total_deaths, new_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2

-- Looking at Total Cases VS Total Deaths 
-- Show likelihood of dying if you contract covid in your country 
Select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location = 'italy'
order by 1,2

-- Looking at the Total Cases versus Population
-- Show what percentage of population got covid
Select location, date, population, total_cases, (total_cases/population) * 100 as PercentPopulationInfected
where location = 'italy'
order by 1,2

-- Looking at the countries with Highest Infection Rate compared to Population 
Select location, population, MAX(total_cases)as HighestInfectionCount, MAX((total_cases/population)) * 100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
group by location, population
order by PercentPopulationInfected desc

-- Show countries with highest death count per Population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc


-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Percentage of total Deat Per Continent
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent	
order by TotalDeathCount desc


-- GLOBAL NUMBERS
-- By day
Select date, SUM(new_cases) as Total_cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/ SUM(new_cases) * 100 as Death_Percentage
from PortfolioProject..CovidDeaths
where continent is not null
Group by date
order by 1,2


--Overall 
Select SUM(new_cases) as Total_cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/ SUM(new_cases) * 100 as Death_Percentage
from PortfolioProject..CovidDeaths
where continent is not null
-- Group by date
order by 1,2


Select*
From PortfolioProject..CovidVaccinations