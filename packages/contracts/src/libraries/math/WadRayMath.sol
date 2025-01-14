// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.25;

/**
 * @title WadRayMath library
 * @author Aave
 * @dev Provides mul and div function for wads (decimal numbers with 18 digits precision) and rays (decimals with 27 digits)
 *
 */
library WadRayMath {
    uint256 internal constant WAD = 1e18;
    uint256 internal constant halfWAD = WAD / 2;

    uint256 internal constant RAY = 1e27;
    uint256 internal constant halfRAY = RAY / 2;

    uint256 internal constant WAD_RAY_RATIO = 1e9;

    /**
     * @return One ray, 1e27
     *
     */
    function ray() internal pure returns (uint256) {
        return RAY;
    }

    /**
     * @return One wad, 1e18
     *
     */
    function wad() internal pure returns (uint256) {
        return WAD;
    }

    /**
     * @return Half ray, 1e27/2
     *
     */
    function halfRay() internal pure returns (uint256) {
        return halfRAY;
    }

    /**
     * @return Half ray, 1e18/2
     *
     */
    function halfWad() internal pure returns (uint256) {
        return halfWAD;
    }

    /**
     * @dev Multiplies two wad, rounding half up to the nearest wad
     * @param a Wad
     * @param b Wad
     * @return The result of a*b, in wad
     *
     */
    function wadMul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0 || b == 0) {
            return 0;
        }

        require(a <= (type(uint256).max - halfWAD) / b, "MATH_MULTIPLICATION_OVERFLOW");

        return (a * b + halfWAD) / WAD;
    }

    function wadDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "MATH_DIVISION_BY_ZERO");
        uint256 halfB = b / 2;

        require(a <= (type(uint256).max - halfB) / WAD, "MATH_MULTIPLICATION_OVERFLOW");

        return (a * WAD + halfB) / b;
    }

    function rayMul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0 || b == 0) {
            return 0;
        }

        require(a <= (type(uint256).max - halfRAY) / b, "MATH_MULTIPLICATION_OVERFLOW");

        return (a * b + halfRAY) / RAY;
    }

    function rayDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "MATH_DIVISION_BY_ZERO");
        uint256 halfB = b / 2;

        require(a <= (type(uint256).max - halfB) / RAY, "MATH_MULTIPLICATION_OVERFLOW");

        return (a * RAY + halfB) / b;
    }

    function rayToWad(uint256 a) internal pure returns (uint256) {
        uint256 halfRatio = WAD_RAY_RATIO / 2;
        uint256 result = halfRatio + a;
        require(result >= halfRatio, "MATH_ADDITION_OVERFLOW");

        return result / WAD_RAY_RATIO;
    }

    function wadToRay(uint256 a) internal pure returns (uint256) {
        uint256 result = a * WAD_RAY_RATIO;
        require(result / WAD_RAY_RATIO == a, "MATH_MULTIPLICATION_OVERFLOW");
        return result;
    }
}
