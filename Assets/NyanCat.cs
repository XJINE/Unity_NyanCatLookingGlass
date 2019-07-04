using UnityEngine;

public class NyanCat : MonoBehaviour
{
    public  Vector3 range = new Vector3(5, 5, 5);
    public  Vector3 speed = Vector3.one;
    private Vector3 basePosition;

    private void Start()
    {
        this.basePosition = base.transform.position;
    }

    void Update()
    {
        Vector3 position = basePosition;

        position.x += Mathf.Cos(Time.timeSinceLevelLoad * speed.x) * range.x;
        position.y += Mathf.Cos(Time.timeSinceLevelLoad * speed.y) * range.y;
        position.z += Mathf.Cos(Time.timeSinceLevelLoad * speed.z) * range.z;

        base.transform.position = position;
    }
}