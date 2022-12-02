using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BezierSurface : MonoBehaviour
{
    //surfaceControlPointsing
    [SerializeField] int numberOfSampePoints;

    //mesh filter for grabbing the mesh
    [SerializeField] private MeshFilter meshFilter;
    private Mesh mesh;

    //The control points
    const int NUMBER_OF_CONTROL_POINTS = 16;
    [Tooltip("4x4 matrix of control points in row major order")]
    [SerializeField] private Transform[] surfaceControlTransforms = new Transform[NUMBER_OF_CONTROL_POINTS];
    private Vector3[] surfaceControlPoints = new Vector3[NUMBER_OF_CONTROL_POINTS];

    private void Awake()
    {
        for (int index = 0; index < NUMBER_OF_CONTROL_POINTS; index++)
        {
            surfaceControlPoints[index] = surfaceControlTransforms[index].position;
        }
    }

    private void Start()
    {
        //get the mesh from the mesh filter
        mesh = meshFilter.mesh;
    }

    private void Update()
    {
        Awake();
        //draw the bezier curve
        for (int drawIndex = 0; drawIndex < 4; drawIndex++)
        {
            drawCurve(Slice(surfaceControlPoints, 4*drawIndex, 4*(drawIndex + 1)), Color.yellow);
        }
    }

    private Vector3[] Slice(Vector3[] data, int start, int end)
    {
        Vector3[] subArray = new Vector3[end - start];

        for (int index = start; index < end; index++)
        {
            subArray[index - start] = new Vector3(data[index].x, data[index].y, data[index].z);
        }

        return subArray;
    }

    private void drawCurve(Vector3[] controlPoints, Color color)
    {
        List<Vector3> samplePoints = new List<Vector3>();
        for (int sampleIndex = 0; sampleIndex < numberOfSampePoints; sampleIndex++)
        {
            float t = (float)sampleIndex / (numberOfSampePoints - 1.0f);
            Vector3 tangent;
            samplePoints.Add(computePointOnBezierCurve(t, controlPoints, out tangent));
        }

        for (int sampleIndex = 0; sampleIndex < samplePoints.Count - 1; sampleIndex++)
        {
            Debug.Log($"Line {sampleIndex}, start point {samplePoints[sampleIndex]}, end point {samplePoints[sampleIndex + 1]}");
            Debug.DrawLine(samplePoints[sampleIndex], samplePoints[sampleIndex + 1], color);
        }
    }

    /*Function to compute the position and tangent on a Bezier surface
    * 
    * t - the parameter t of the Bezier curve
    * controlPoints - list of control points to define the curve, row major order
    * 
    * return:
    *  Value - the position of the point on the curve
    *  tangent - the tangent vector of the Bezier curve at the point
    */
    // private Vector3 computePointOnBezierSurface(float u, float v, Vector3[] controlPoints, out Vector3 tangent)
    // {
    //     // Vector3 vControl
    // }

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
            {
                //compute the control point one level down
                Debug.Log($"Control Point {intermmediateControlPoints[bezierIndex]}, level {bezierOrder}, point {bezierIndex}, t {t}");
                intermmediateControlPoints[bezierIndex] = ((1 - t)*intermmediateControlPoints[bezierIndex]) + (t*intermmediateControlPoints[bezierIndex + 1]);
            }

            bezierOrder--;
        }

        //now the first two elements are of interest

        //compute unit tangent
        tangent = (intermmediateControlPoints[1] - intermmediateControlPoints[0]).normalized;

        //compute and return the position
        return ((1 - t)*intermmediateControlPoints[0]) + (t*intermmediateControlPoints[1]);
    }
}
