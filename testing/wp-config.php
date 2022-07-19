<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpressdb' );

/** MySQL database username */
define( 'DB_USER', 'ashutosh' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'db:3306' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '@O0hH5;b4]B_&IwT!5Fc;2ZQV3UA(tHr2dwT V{Mx1J(o&E-Bld3Rh?s8r~;p2nP' );
define( 'SECURE_AUTH_KEY',  '!b;%*5w.X|5P.5~+M8TWy0tB?jdqgtoS^wOF@O+G.jPn9JH5Sqg|U]s_CC0/1f&N' );
define( 'LOGGED_IN_KEY',    'kB~_l|R`S7ga4rD- 6@^#p%C<*Nn9TCOP/Hs{}:d32FqT) @tcp-Uzl:v-e~v[[d' );
define( 'NONCE_KEY',        'Rb/95v>gX^wn6%qZb$?-u+:9&k}hL)iDP9S 8JDiNj.-<Q+3iZpVIIPusAj9$C5(' );
define( 'AUTH_SALT',        'SPVH+wBgyT{jAZW=^]^B#[zv(+qbW&&vPlG?xU6aj{*UJD,EHIF^U(_]zbq/4:E:' );
define( 'SECURE_AUTH_SALT', 'VY~5$9rJCj}enn$W4g^,y%X0MK%-lXO364puci_c?zk58hLpS4;$V`e).`]u$PH0' );
define( 'LOGGED_IN_SALT',   'i^,2Y5AH%M}E5!1?#)Bu&[h%miq4AF1j1q*-mI&|Hw>>!G+;d85|y.Jqxh}<x@sG' );
define( 'NONCE_SALT',       '7~d ,ReW #Lp[BJ/|k*QL?Xe2] m0~Y#RB:rn0PPdepImaCX#.LwQ|28!|lxtCVF' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
