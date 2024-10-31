using System.Collections;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

public class CombineMesh : MonoBehaviour
{
    public GameObject go;
    // Start is called before the first frame update
    void Start()
    {
        MeshFilter meshFilter = GetComponentInChildren<MeshFilter>();

        CombineInstance[] combines = new CombineInstance[meshFilter.mesh.subMeshCount];
        for (int i = 0; i < meshFilter.mesh.subMeshCount; i++)
        {
            combines[i].mesh = meshFilter.sharedMesh;
            combines[i].transform = meshFilter.transform.localToWorldMatrix;
            combines[i].subMeshIndex = i;
        }

        Mesh combinedMesh = new Mesh();

        // ����IndexFormatΪUInt32��֧�ֳ���65535������
        combinedMesh.indexFormat = IndexFormat.UInt32;

        combinedMesh.CombineMeshes(combines, true);

        // ���ϲ�������񸳸���ǰ�����MeshFilter
        MeshFilter currentMeshFilter = go.AddComponent<MeshFilter>();
        currentMeshFilter.mesh = combinedMesh;

#if UNITY_EDITOR
        // ����ϲ��������Ϊһ��.asset�ļ�
        string path = "Assets/CombinedMesh.asset";
        AssetDatabase.CreateAsset(combinedMesh, path);
        AssetDatabase.SaveAssets();
        Debug.Log("Combined mesh saved at " + path);
#endif
    }

}
