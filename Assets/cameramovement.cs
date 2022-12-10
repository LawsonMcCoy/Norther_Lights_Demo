using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cameramovement : MonoBehaviour
{
    // Start is called before the first frame update
  
    private Transform trans;
    // Update is called once per frame
    void Start(){
        trans = gameObject.GetComponent<Transform>();
    }
    void Update()
    {
        if (Input.GetKeyDown("w")){

            trans.Translate(Vector3.forward);
        }
        if (Input.GetKeyDown("s")){

            trans.Translate(Vector3.back);
            }        
        if (Input.GetKeyDown("d")){

            trans.Translate(Vector3.right);
        }
        if (Input.GetKeyDown("a")){

           trans.Translate(Vector3.left);
        }
        if (Input.GetKeyDown("space")){

            trans.Translate(Vector3.up);
        }
        
        if (Input.GetKeyDown("x")){

            trans.Translate(Vector3.down);
        }
        
        
    }
}
