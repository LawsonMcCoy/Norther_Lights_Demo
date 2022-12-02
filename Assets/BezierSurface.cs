using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BezierSurface : MonoBehaviour
{
    //mesh filter for grabbing the mesh
    [SerializeField] private MeshFilter meshFilter;
    private Mesh mesh;

    //The control points
    [Tooltip("4x4 matrix of control points in column major order")]
    [SerializeField] private Transform[] test = new Transform[16];

    private void Start()
    {
        mesh = meshFilter.mesh;
    }
}
