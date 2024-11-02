using UnityEngine;

public class RotateCamera : MonoBehaviour
{
    [Tooltip("相机朝向的目标点")]
    public Transform lookAt;

    [Tooltip("相机旋转的半径")]
    public float radius = 5f;

    [Tooltip("旋转一周所需的时间（秒）")]
    public float timeToRotate = 10f;

    [Tooltip("相机的垂直偏移")]
    public float heightOffset = 2f;

    private float currentAngle = 0f;

    void Update()
    {
        if (lookAt == null)
        {
            Debug.LogWarning("请在编辑器中设置 lookAt 目标！");
            return;
        }

        // 计算每帧旋转的角度
        float anglePerFrame = (360f / timeToRotate) * Time.deltaTime;
        currentAngle += anglePerFrame;

        // 确保角度在 0-360 度之间
        currentAngle %= 360f;

        // 计算相机的新位置
        float x = lookAt.position.x + radius * Mathf.Cos(currentAngle * Mathf.Deg2Rad);
        float z = lookAt.position.z + radius * Mathf.Sin(currentAngle * Mathf.Deg2Rad);
        float y = lookAt.position.y + heightOffset;

        // 设置相机位置
        transform.position = new Vector3(x, y, z);

        // 让相机朝向目标点
        transform.LookAt(lookAt);
    }

    // 在编辑器中可视化旋转路径
    void OnDrawGizmosSelected()
    {
        if (lookAt == null) return;

        Gizmos.color = Color.yellow;
        Gizmos.DrawWireSphere(lookAt.position, radius);
    }
}