extends BaseEntity

class_name ContainerEntity

func instantiate() -> BaseEntity:
	return SceneRegistry.Entities.WOODEN_CHEST.instantiate() as ContainerEntity


func mesh() -> Mesh:
	return Meshes.WOODEN_CHEST
