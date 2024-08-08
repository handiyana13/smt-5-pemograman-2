-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 02, 2024 at 01:14 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aplikasi_perpus`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `year` year(4) NOT NULL,
  `available` tinyint(1) DEFAULT '1',
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `publisher`, `year`, `available`, `image_url`) VALUES
(1, 'Pemograman Web Vol. 1', 'Handiyana NH', 'Buku tentang mempelajari HTML, CSS dan JS', 2022, 1, 'cover/cover.png'),
(2, 'Pemograman Web Vol. 2', 'Handiyana NH', 'Lanjutan seri sebelumnya, yaitu mempelajari framework Boostrap', 2023, 1, 'cover/cover.png'),
(3, 'Pemograman Web Vol. 3', 'Handiyana NH', 'Tahap akhir, mempelajari bahasa pemograman PHP dan Framework CodeIgniter 4', 2024, 1, 'cover/cover.png'),
(4, 'Siska Kubur', 'Garox Asmoking', 'Buku tentang balasan semasa hidup didunia akan di pertanggungjawabkan di akhirat', 2021, 1, 'cover/cover.png'),
(5, 'Filosofi Teras', 'Henry Manampiring', 'Sebuah buku pengantar filsafat Stoa yang dibuat khusus sebagai panduan moral anak muda', 2018, 1, 'cover/cover.png'),
(6, 'Terjemah Fathul Izar', 'Bahrudin Achmad', 'Meningkatkan keimanan, menyempurnakan agama', 2021, 1, 'cover/cover.png'),
(7, 'Buku Sakti Hacker', 'Efvy Zam', 'Setelah membaca ini anda akan bisa menjadi hekel pro', 2019, 1, 'cover/cover.png');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `loan_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `returned` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `book_id`, `member_id`, `loan_date`, `return_date`, `returned`) VALUES
(7, 4, 2, '2024-07-02', '2024-07-02', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `role`) VALUES
(1, 'admin', '202cb962ac59075b964b07152d234b70', 'admin@gmail.com', 'admin'),
(2, 'yana', 'e1ce1e8d0877b06b55b613d5b22b0251', 'yana@gmail.com', 'user'),
(4, 'han', '83832391027a1f2f4d46ef882ff3a47d', 'handiggb2@gmail.com', 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `loans_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
