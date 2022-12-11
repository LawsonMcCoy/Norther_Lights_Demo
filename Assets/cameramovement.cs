using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cameramovement : MonoBehaviour
{
    // Start is called before the first frame update
    

  private const int MoveAmount = 20;
    private Transform trans;
    void Start(){
        trans = gameObject.GetComponent<Transform>();

        //lock the curser when controlling the player
        Cursor.lockState = CursorLockMode.Locked;
    }
    void Update()
    {
        if (Input.GetKeyDown("w")){

            trans.Translate(Vector3.forward*MoveAmount);
        }
        if (Input.GetKeyDown("s")){

            trans.Translate(Vector3.back*MoveAmount);
            }        
        if (Input.GetKeyDown("d")){

            trans.Translate(Vector3.right*MoveAmount);
        }
        if (Input.GetKeyDown("a")){

           trans.Translate(Vector3.left*MoveAmount);
        }
        if (Input.GetKeyDown("space")){

            trans.Translate(Vector3.up*MoveAmount);
        }
        
        if (Input.GetKeyDown("x")){

            trans.Translate(Vector3.down*MoveAmount);
        }
        if(Input.GetKeyDown(KeyCode.Escape)){
            Application.Quit();
        }

         float h = 2.0f * Input.GetAxis("Mouse X");
        float v = 2.0f * Input.GetAxis("Mouse Y");

        trans.Rotate(trans.right, -v);
        trans.Rotate(Vector3.up, h);

    }
    void OnCollisionEnter(Collision collision){
        
        ContactPoint contact = collision.contacts[0];
        //Quaternion rotation = Quaternion.FromToRotation(Vector3.up, contact.normal);
        Vector3 position = contact.point;
    }
}
