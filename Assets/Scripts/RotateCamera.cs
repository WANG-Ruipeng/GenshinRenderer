using UnityEngine;

public class RotateCamera : MonoBehaviour
{
    [Tooltip("��������Ŀ���")]
    public Transform lookAt;

    [Tooltip("�����ת�İ뾶")]
    public float radius = 5f;

    [Tooltip("��תһ�������ʱ�䣨�룩")]
    public float timeToRotate = 10f;

    [Tooltip("����Ĵ�ֱƫ��")]
    public float heightOffset = 2f;

    private float currentAngle = 0f;

    void Update()
    {
        if (lookAt == null)
        {
            Debug.LogWarning("���ڱ༭�������� lookAt Ŀ�꣡");
            return;
        }

        // ����ÿ֡��ת�ĽǶ�
        float anglePerFrame = (360f / timeToRotate) * Time.deltaTime;
        currentAngle += anglePerFrame;

        // ȷ���Ƕ��� 0-360 ��֮��
        currentAngle %= 360f;

        // �����������λ��
        float x = lookAt.position.x + radius * Mathf.Cos(currentAngle * Mathf.Deg2Rad);
        float z = lookAt.position.z + radius * Mathf.Sin(currentAngle * Mathf.Deg2Rad);
        float y = lookAt.position.y + heightOffset;

        // �������λ��
        transform.position = new Vector3(x, y, z);

        // ���������Ŀ���
        transform.LookAt(lookAt);
    }

    // �ڱ༭���п��ӻ���ת·��
    void OnDrawGizmosSelected()
    {
        if (lookAt == null) return;

        Gizmos.color = Color.yellow;
        Gizmos.DrawWireSphere(lookAt.position, radius);
    }
}