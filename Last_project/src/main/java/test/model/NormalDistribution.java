package test.model;

import java.util.ArrayList;
import java.util.List;

public class NormalDistribution {
    public static List<Double> getNormalDistributionData(double mean, double stdDev, int numPoints) {
        List<Double> data = new ArrayList<Double>();
        double step = (6 * stdDev) / numPoints; 
        double start = mean - 3 * stdDev;
        for (int i = 0; i < numPoints; i++) {
            double x = start + i * step;
            double y = (1 / (stdDev * Math.sqrt(2 * Math.PI))) * Math.exp(-0.5 * Math.pow((x - mean) / stdDev, 2));
            data.add(y);
        }
        return data;
    }
}