__author__ = 'Saqib'
"""
This script creates an image pyramid using the built-in functions of VIGRA
"""
import numpy
import vigra


def main():
    """
    Test code
    :return:
    """
    image = vigra.readImage('C:/Users/Saqib/Desktop/Koala.jpg')
    pyramid_1 = get_gaussian_pyramid(image, 4)
    pyramid_2 = get_gaussian_pyramid_2(image, 4)
    # print str(pyramid_1) == str(pyramid_2)

    # Get Gaussian Pyramid for the image
    for i in pyramid_1:
        i.imshow()

    lap_pyramid = get_laplacian_pyramid(image, 4)
    for j in lap_pyramid:
        j.imshow()
    get_laplacian_pyramid(image, 4)
    # image.imshow()


def get_gaussian_pyramid(image, levels):
    """
    Construct Gaussian Pyramid of an image.
    :param image: The image whose Gaussian Pyramid is to be created
    :param levels: The number of levels in the pyramid
    :return: A list containing the images that constitute the pyramid
    """

    pyramid = list()
    clone = image.copy()
    pyramid.append(clone)
    for i in xrange(levels - 1):
        clone = vigra.sampling.resampleImage(clone, 0.5)
        pyramid.append(clone)

    return pyramid


def get_gaussian_pyramid_2(image, levels):
    """
    Construct Gaussian Pyramid of an image.
    :param image: The image whose Gaussian Pyramid is to be created
    :param levels: The number of levels in the pyramid
    :return: A list containing the images that constitute the pyramid
    """
    factor = 0.5
    pyramid = list()
    pyramid.append(image)
    for i in xrange(levels - 1):
        pyramid.append(vigra.sampling.resampleImage(image, factor))
        factor *= 0.5

    return pyramid


def get_laplacian_pyramid(image, levels):
    """
    Construct Laplacian Pyramid of an image.
    :param image: The image whose Laplacian Pyramid is to be created
    :param levels: The number of levels in the pyramid
    :return: A list containing the images that constitute the pyramid
    """
    g_pyramid = get_gaussian_pyramid(image, levels)
    l_pyramid = list()

    for i in xrange(levels - 1, 0, -1):
        up_scaled = vigra.sampling.resampleImage(g_pyramid[i], 2)
        difference = vigra.ufunc.subtract(g_pyramid[i - 1], up_scaled)
        diff2 = vigra.ufunc.subtract(up_scaled, g_pyramid[i - 1])

        l_pyramid.append(difference)

    return l_pyramid


main()