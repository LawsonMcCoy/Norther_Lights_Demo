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

            trans.Translate(Vector3.forward*50);
        }
        if (Input.GetKeyDown("s")){

            trans.Translate(Vector3.back*1);
            }        
        if (Input.GetKeyDown("d")){

            trans.Translate(Vector3.right*30);
        }
        if (Input.GetKeyDown("a")){

           trans.Translate(Vector3.left*5);
        }
        if (Input.GetKeyDown("space")){

            trans.Translate(Vector3.up*150);
        }
        
        if (Input.GetKeyDown("x")){

            trans.Translate(Vector3.down);
        }

         float h = 2.0f * Input.GetAxis("Mouse X");
        float v = 2.0f * Input.GetAxis("Mouse Y");

        trans.Rotate(v, h, 0);

    }
    void OnCollisionEnter(Collision collision){
        
        ContactPoint contact = collision.contacts[0];
        //Quaternion rotation = Quaternion.FromToRotation(Vector3.up, contact.normal);
        Vector3 position = contact.point;
    }
}
