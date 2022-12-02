using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BezierSurface : MonoBehaviour
{
    //testing
    [SerializeField] int numberOfSampePoints;

    //mesh filter for grabbing the mesh
    [SerializeField] private MeshFilter meshFilter;
    private Mesh mesh;

    //The control points
    [Tooltip("4x4 matrix of control points in column major order")]
    [SerializeField] private Vector3[] test = new Vector3[16];

    private void Start()
    {
        //get the mesh from the mesh filter
        mesh = meshFilter.mesh;
    }

    private void Update()
    {
        //draw the bezier curve
        List<Vector3> samplePoints = new List<Vector3>();
        for (int sampleIndex = 0; sampleIndex < numberOfSampePoints; sampleIndex++)
        {
            float t = (float)sampleIndex / (samplePoints.Count - 1.0f);
            Vector3 tangent;
            samplePoints.Add(computePointOnBezierCurve(t, Slice(test, 0, 4), out tangent));
        }

        Debug.Log(samplePoints.Count - 1);
        for (int sampleIndex = 0; sampleIndex < samplePoints.Count - 1; sampleIndex++)
        {
            Debug.Log($"Line {sampleIndex}, start point {samplePoints[sampleIndex]}, end point {samplePoints[sampleIndex + 1]}");
            Debug.DrawLine(samplePoints[sampleIndex], samplePoints[sampleIndex + 1], Color.yellow);
        }
    }

    private Vector3[] Slice(Vector3[] data, int start, int end)
    {
        Vector3[] subArray = new Vector3[end - start];

        for (int index = start; index < end; index++)
        {
            subArray[index - start] = data[index];
        }

        return subArray;
    }



    /*Function to compute the position and tangent on a Bezier curve
    * 
    * t - the parameter t of the Bezier curve
    * controlPoints - list of control points to define the curve
    * 
    * return:
    *  Value - the position of the point on the curve
    *  tangent - the tangent vector of the Bezier curve at the point
    */
    private Vector3 computePointOnBezierCurve(float t, Vector3[] controlPoints, out Vector3 tangent)
    {
        //make a deep copy of the control points so we can edit them
        List<Vector3> intermmediateControlPoints = new List<Vector3>(controlPoints);

        //the order of the Bezier curve (number of control points - 1),
        //loop until this value is 1
        int bezierOrder = intermmediateControlPoints.Count - 1;

        //loop until we have 2 controls points (when order is one),
        //at that point we are able to compute tangent and position
        while (bezierOrder > 1)
        {
            //iterate through control points
            for (int bezierIndex = 0; bezierIndex < bezierOrder; bezierIndex++)

            //compute the control point one level down
            intermmediateControlPoints[bezierIndex] = ((1 - t)*intermmediateControlPoints[bezierIndex]) + (t*intermmediateControlPoints[bezierIndex + 1]);
        }

        //now the first two elements are of interest

        //compute unit tangent
        tangent = (intermmediateControlPoints[1] - intermmediateControlPoints[0]).normalized;

        //compute and return the position
        return ((1 - t)*intermmediateControlPoints[0]) + (t*intermmediateControlPoints[1]);
    }
}
